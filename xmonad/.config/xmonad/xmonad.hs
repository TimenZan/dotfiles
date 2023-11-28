{-# OPTIONS_GHC -Wno-missing-signatures #-}

import qualified Data.Map as M
import System.Exit
import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.ManageDocks

import XMonad.Layout.ThreeColumns
import qualified XMonad.StackSet as W

import XMonad.Hooks.DynamicLog (PP (ppCurrent, ppSep, ppTitle), shorten, xmobarColor, xmobarPP)
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageHelpers (isDialog)
import XMonad.Hooks.StatusBar (statusBarProp, withEasySB)
import XMonad.Hooks.WindowSwallowing (swallowEventHook)
import XMonad.Layout.Accordion (Accordion (Accordion))
import XMonad.Layout.Magnifier (magnifiercz')
import XMonad.Layout.Renamed (Rename (Replace), renamed)
import XMonad.Layout.Spiral (spiral)
import XMonad.Util.SpawnOnce (spawnOnce)

-- The command to lock the screen or show the screensaver.
myScreensaver :: String
myScreensaver = "/usr/bin/xscreensaver-command -l"

-- The command to take a selective screenshot, where you select
-- what you'd like to capture on the screen.
mySelectScreenshot :: String
mySelectScreenshot = "flameshot gui"

-- The command to take a fullscreen screenshot.
myScreenshot :: String
myScreenshot = "flameshot"

-- The command to use as a launcher, to launch commands that don't have
-- preset keybindings.
myLauncher :: String
myLauncher = "dmenu-frecency"

myWorkspaces :: [String]
myWorkspaces = ["1:web", "2:background", "3:chat", "4:music", "5:code"] ++ map show [(6 :: Integer) .. 9]

-- myLayout = onWorkspace "3:chat" (Mirror (Tall 1 (3 / 100) (1 / 2)))
--                 $ onWorkspace "9" (noBorders (fullscreenFull Full))
--                 $ avoidStruts
--                         ( ThreeColMid 1 (3 / 100) (1 / 2)
--                                 ||| Tall 1 (3 / 100) (1 / 2)
--                                 ||| Mirror (Tall 1 (3 / 100) (1 / 2))
--                                 -- \||| tabbed shrinkText tabConfig
--                                 ||| Full
--                                 ||| spiral (6 / 7)
--                         )
--                 ||| noBorders (fullscreenFull Full)

myLayout =
  threeCol
    ||| magThreeCol
    ||| Accordion
    ||| Tall 1 (3 / 100) (1 / 2)
    ||| Mirror (Tall 1 (3 / 100) (1 / 2))
    ||| Full
    ||| spiral (6 / 7)
 where
  threeCol = ThreeColMid 1 (3 / 100) (1 / 2)
  magThreeCol =
    renamed [Replace "ThreeCol Magnified"]
      $ magnifiercz' 1.4 threeCol

------------------------------------------------------------------------
-- Colors and borders
-- Currently based on the ir_black theme.
--
myNormalBorderColor = "#000000"
myFocusedBorderColor = "#808080"

-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
-- tabConfig
--   = defaultTheme{activeBorderColor = "#7C7C7C", activeTextColor = "#CEFFAC",
--                  activeColor = "#000000", inactiveBorderColor = "#C7C7C",
--                  inactiveTextColor = "#EEEEEE", inactiveColor = "#000000"}

-- Color of current window title in xmobar.
xmobarTitleColor = "#FFB6B0"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#CEFFAC"

-- Width of the window border in pixels.
myBorderWidth = 1

------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask

myKeys conf@XConfig{XMonad.modMask = modMask} =
  M.fromList
    $ [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
      , ((modMask .|. controlMask, xK_l), spawn myScreensaver)
      , ((modMask, xK_p), spawn myLauncher)
      , ((0, xK_Print), spawn mySelectScreenshot)
      , ((modMask .|. controlMask .|. shiftMask, xK_p), spawn myScreenshot)
      , ((modMask .|. shiftMask, xK_c), kill)
      , ((modMask, xK_space), sendMessage NextLayout)
      , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
      , ((modMask, xK_n), refresh)
      , ((modMask, xK_Tab), windows W.focusDown)
      , ((modMask, xK_j), windows W.focusDown)
      , ((modMask, xK_k), windows W.focusUp)
      , ((modMask, xK_m), windows W.focusMaster)
      , ((modMask, xK_Return), windows W.swapMaster)
      , ((modMask .|. shiftMask, xK_j), windows W.swapDown)
      , ((modMask .|. shiftMask, xK_k), windows W.swapUp)
      , ((modMask, xK_h), sendMessage Shrink)
      , ((modMask, xK_l), sendMessage Expand)
      , ((modMask, xK_t), withFocused $ windows . W.sink)
      , ((modMask, xK_comma), sendMessage (IncMasterN 1))
      , ((modMask, xK_period), sendMessage (IncMasterN (-1)))
      , ((modMask .|. shiftMask, xK_q), io exitSuccess)
      , ((modMask, xK_q), restart "xmonad" True)
      ]
    ++ [ ((m .|. modMask, k), windows $ f i)
       | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
       , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
       ]
    ++ [ ( (m .|. modMask, key)
         , screenWorkspace sc >>= flip whenJust (windows . f)
         )
       | (key, sc) <- zip [xK_w, xK_e, xK_r] [2, 0, 1]
       , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
       ]

myMouseBindings XConfig{XMonad.modMask = modMask} =
  M.fromList
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modMask, button1), \w -> focus w >> mouseMoveWindow w)
    , -- mod-button2, Raise the window to the top of the stack
      ((modMask, button2), \w -> focus w >> windows W.swapMaster)
    , -- mod-button3, Set the window to floating mode and resize by dragging
      ((modMask, button3), \w -> focus w >> mouseResizeWindow w)
    ]

myManageHook :: ManageHook
myManageHook =
  composeAll
    [ className =? "Gimp" --> doFloat
    , isDialog --> doFloat
    ]

myStartupHook = do
  spawnOnce "dunst"
  spawnOnce "xcape"
  spawnOnce "feh --bg-scale ~/.bg.png"

myXmobarPP :: PP
myXmobarPP =
  xmobarPP
    { ppTitle = xmobarColor xmobarTitleColor "" . shorten 50
    , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
    , ppSep = "   "
    }

main = do
  xmonad
    $ ewmh
    $ docks
    $ withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) toggleStrutsKey
    $ def
      { terminal = "kitty"
      , focusFollowsMouse = True
      , borderWidth = myBorderWidth
      , modMask = myModMask
      , workspaces = myWorkspaces
      , normalBorderColor = myNormalBorderColor
      , focusedBorderColor = myFocusedBorderColor
      , keys = myKeys
      , mouseBindings = myMouseBindings
      , layoutHook = myLayout
      , manageHook = myManageHook <+> manageDocks <+> manageSpawn
      , startupHook = myStartupHook
      , handleEventHook = swallowEventHook (className =? "Alacritty" <||> className =? "Kitty") (return True)
      , logHook = updatePointer (0.5, 0.5) (0, 0)
      }
 where
  toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
  toggleStrutsKey XConfig{modMask = m} = (m, xK_b)
