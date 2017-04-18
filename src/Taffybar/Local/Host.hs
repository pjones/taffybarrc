{- This file is part of the taffybarrc package. It is subject to the
license terms in the LICENSE file found in the top-level directory of
this distribution and at git://pmade.com/taffybarrc/LICENSE. No part
of the taffybarrc package, including this file, may be copied,
modified, propagated, or distributed except according to the terms
contained in the LICENSE file. -}

--------------------------------------------------------------------------------
-- | Per-host configuration for Taffybar.
module Taffybar.Local.Host
       ( Host (..)
       , getHostConfig
       ) where

--------------------------------------------------------------------------------
import Graphics.UI.Gtk (Widget)
import Network.HostName
import Taffybar.Local.Pager
import Taffybar.Local.Widgets

--------------------------------------------------------------------------------
-- | Host configuration.
data Host = Host
  { primaryMonitorNum :: Int
  , leftWidgets       :: [IO Widget]
  , rightWidgets      :: [IO Widget]
  }

--------------------------------------------------------------------------------
-- | Get the proper configuration for the current host.
getHostConfig :: IO Host
getHostConfig = do
  name <- getHostName
  return $ case name of
    "slugworth" -> hostSlugworth
    _           -> hostDefault

--------------------------------------------------------------------------------
-- | Default configuration (for my desktop).
hostDefault :: Host
hostDefault =  Host
  { primaryMonitorNum = 1
  , leftWidgets       = [pager (pagerConfig 50)]
  , rightWidgets      = [clock, tray]
  }

--------------------------------------------------------------------------------
-- | My primary laptop.
hostSlugworth :: Host
hostSlugworth =  Host
  { primaryMonitorNum = 0
  , leftWidgets       = [pager (pagerConfig 40)]
  , rightWidgets      = [clock, battery, tray]
  }
