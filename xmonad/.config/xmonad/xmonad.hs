{-# OPTIONS_GHC -Wno-missing-signatures #-}

import qualified Data.Map as M
import System.Exit
import XMonad
import XMonad.Actions.SpawnOn
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.ManageDocks

import XMonad.Layout.ThreeColumns
import qualified XMonad.StackSet as W

import System.Posix.Unistd (
  SystemID (nodeName),
  getSystemID,
 )
import XMonad.Actions.CycleWS
import XMonad.Actions.Minimize (
  maximizeWindowAndFocus,
  minimizeWindow,
  withLastMinimized,
 )
import XMonad.Hooks.EwmhDesktops (ewmh, setEwmhActivateHook)
import XMonad.Hooks.FloatConfigureReq (
  fixSteamFlickerMMMH,
  floatConfReqHook,
 )
import XMonad.Hooks.ManageHelpers (
  doFullFloat,
  isDialog,
  isFullscreen,
  (/=?),
 )
import XMonad.Hooks.RefocusLast (refocusLastLogHook)
import XMonad.Hooks.StatusBar (statusBarProp, withEasySB)
import XMonad.Hooks.StatusBar.PP (
  PP (ppCurrent, ppSep, ppTitle),
  filterOutWsPP,
  shorten,
  xmobarColor,
  xmobarPP,
 )
import XMonad.Hooks.UrgencyHook (doAskUrgent)
import XMonad.Hooks.WindowSwallowing (
  swallowEventHook,
  swallowEventHookSub,
 )
import XMonad.Layout.Accordion (Accordion (Accordion))
import XMonad.Layout.BoringWindows (
  boringWindows,
  focusDown,
  focusMaster,
  focusUp,
 )
import XMonad.Layout.CenterMainFluid (CenterMainFluid (CenterMainFluid))
import XMonad.Layout.Decoration (shrinkText)
import XMonad.Layout.Fullscreen (fullscreenFull)
import XMonad.Layout.HintedGrid (Grid (Grid))
import XMonad.Layout.Magnifier (magnifiercz)
import XMonad.Layout.Minimize (minimize)
import XMonad.Layout.MultiToggle
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.PerWorkspace (onWorkspace)
import XMonad.Layout.Reflect
import XMonad.Layout.Renamed (Rename (CutWordsLeft), renamed)
import XMonad.Layout.Roledex (Roledex (Roledex))
import XMonad.Layout.Simplest
import XMonad.Layout.SubLayouts
import XMonad.Layout.Tabbed
import XMonad.Util.Hacks (fixSteamFlicker)
import XMonad.Util.NamedScratchpad (
  NamedScratchpad (NS),
  customFloating,
  namedScratchpadAction,
  namedScratchpadManageHook,
  nsHideOnFocusLoss,
  scratchpadWorkspaceTag,
 )
import XMonad.Util.SpawnOnce (spawnOnOnce, spawnOnce)
import XMonad.Util.Themes

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
myWorkspaces = map show [(1 :: Integer) .. 9]

myTabTheme =
  (theme kavonForestTheme)
    { fontName = "xft:monospace:pixelsize=12:antialias=true:hinting=true"
    , decoHeight = 15
    }

myLayout =
  renamed [CutWordsLeft 2]
    $ minimize
    $ boringWindows
    $ smartBorders
    $ addTabs shrinkText myTabTheme
    $ subLayout [] Simplest
    $ mkToggle (single REFLECTX)
    $ onWorkspace
      "2"
      ( Accordion
          -- \||| magnifiercz 1.4 (Mirror $ Tall 1 (3 / 100) (1 / 2))
          ||| Mirror (Tall 1 (3 / 100) (1 / 2))
      )
    $ onWorkspace
      "4"
      (Mirror Accordion)
    $ onWorkspace
      "9"
      (noBorders (fullscreenFull Full))
      ( CenterMainFluid 1 (3 / 100) 0.50
          ||| threeCol
          -- \||| Tall 1 (3 / 100) (1 / 2)
          ||| Full
          ||| Grid False
          ||| Roledex
      )
 where
  -- \||| spiral (16 / 9)

  threeCol =
    ThreeCol 1 (3 / 100) (1 / 2)

-- magThreeCol =
--   renamed [Replace "ThreeCol Magnified"] $
--     magnifiercz' 1.4 threeCol

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
-- Scratchpads
scratchpads =
  -- TODO change theme to make clear it's a scratchpad
  [NS "term" "kitty --class NNscratchpad --single-instance" (className =? "NNscratchpad") bigFloat]
 where
  -- TODO: position correctly
  -- rect: marginLeft marginTop width height
  bigFloat = customFloating $ W.RationalRect (2 / 6) (1 / 6) (2 / 4) (2 / 3)

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
    $ [ ((modMask .|. shiftMask, xK_Return), spawn $ terminal conf)
      , ((modMask .|. controlMask, xK_l), spawn myScreensaver)
      , ((modMask, xK_r), namedScratchpadAction scratchpads "term")
      , ((modMask, xK_v), withFocused minimizeWindow)
      , ((modMask .|. shiftMask, xK_v), withLastMinimized maximizeWindowAndFocus)
      , ((modMask, xK_d), spawn myLauncher)
      , ((0, xK_Print), spawn mySelectScreenshot)
      , ((modMask .|. controlMask .|. shiftMask, xK_p), spawn myScreenshot)
      , ((modMask .|. shiftMask, xK_c), kill)
      , ((modMask, xK_space), sendMessage NextLayout)
      , ((modMask .|. shiftMask, xK_space), setLayout $ layoutHook conf)
      , ((modMask, xK_Tab), focusDown)
      , ((modMask, xK_j), focusDown)
      , ((modMask, xK_k), focusUp)
      , ((modMask, xK_m), focusMaster)
      , ((modMask, xK_Return), windows W.swapMaster)
      , ((modMask .|. shiftMask, xK_j), windows W.swapDown)
      , ((modMask .|. shiftMask, xK_k), windows W.swapUp)
      , -- , ((modMask .|. controlMask, xK_h), sendMessage $ pullGroup L)
        -- , ((modMask .|. controlMask, xK_l), sendMessage $ pullGroup R)
        -- , ((modMask .|. controlMask, xK_k), sendMessage $ pullGroup U)
        -- , ((modMask .|. controlMask, xK_j), sendMessage $ pullGroup D)
        -- For some reason this merges with the one below the one below
        ((modMask .|. controlMask, xK_j), withFocused (sendMessage . mergeDir W.focusDown'))
      , ((modMask .|. controlMask, xK_k), withFocused (sendMessage . mergeDir W.focusUp'))
      , ((modMask .|. controlMask, xK_m), withFocused (sendMessage . MergeAll))
      , ((modMask .|. controlMask, xK_u), withFocused (sendMessage . UnMerge))
      , ((modMask .|. controlMask, xK_period), onGroup W.focusUp')
      , ((modMask .|. controlMask, xK_comma), onGroup W.focusDown')
      , -- , ((modMask, xK_s), submap $ defaultSublMap conf)
        ((modMask, xK_h), sendMessage Shrink)
      , ((modMask, xK_l), sendMessage Expand)
      , ((modMask, xK_t), withFocused $ windows . W.sink)
      , ((modMask, xK_comma), sendMessage (IncMasterN 1))
      , ((modMask, xK_period), sendMessage (IncMasterN (-1)))
      , ((modMask .|. controlMask, xK_x), sendMessage $ Toggle REFLECTX)
      , ((modMask .|. shiftMask, xK_q), io exitSuccess)
      , ((modMask, xK_q), restart "xmonad" True)
      , ((modMask, xK_n), nextScreen)
      , ((modMask .|. shiftMask, xK_n), shiftNextScreen)
      , ((modMask .|. controlMask, xK_n), swapNextScreen)
      ]
    ++ [ ((m .|. modMask, k), windows $ f i)
       | (i, k) <- zip (workspaces conf) [xK_1 .. xK_9]
       , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
       ]
    ++ [ ( (m .|. modMask, key)
         , screenWorkspace sc >>= flip whenJust (windows . f)
         )
       | (key, sc) <- zip [xK_f, xK_p] [0, 1]
       , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
       ]

-- ++ [ ( (m .|. modMask, key)
--      , screenWorkspace sc >>= flip whenJust (windows . f)
--      )
--    | (key, sc) <- zip [xK_e, xK_r] [0, 1]
--    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
--    ]

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
    , moveC "discord" "2"
    , moveC "Steam" "9"
    , isFullscreen --> (doF W.focusDown <+> doFullFloat)
    ]
 where
  moveC c w = className =? c --> doShift w

desktopStartupHook = do
  spawnOnOnce "9" "nice qbittorrent"
  spawnOnOnce "9" "steam"
  spawnOnOnce "4" "spotify"

laptopStartupHook = do
  spawnOnce "dunst"
  spawnOnce "xcape"
  spawnOnce "blueman-applet"
  spawnOnce "feh --bg-scale ~/.bg.png"

allStartupHook = do
  spawnOnce "picom -b"
  spawnOnOnce "NSP" "kitty --class NNscratchpad --single-instance"

myXmobarPP :: PP
myXmobarPP =
  filterOutWsPP
    [scratchpadWorkspaceTag]
    $ xmobarPP
      { ppTitle = xmobarColor xmobarTitleColor "" . shorten 50
      , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
      , ppSep = "   "
      }

main = do
  host <- fmap nodeName getSystemID
  xmonad
    $ setEwmhActivateHook doAskUrgent
    $ ewmh
    $ docks
    $ withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) toggleStrutsKey
    $ def
      { terminal = "kitty -1"
      , focusFollowsMouse = True
      , borderWidth = myBorderWidth
      , modMask = myModMask
      , workspaces = myWorkspaces
      , normalBorderColor = myNormalBorderColor
      , focusedBorderColor = myFocusedBorderColor
      , keys = myKeys
      , mouseBindings = myMouseBindings
      , layoutHook = myLayout
      , manageHook = namedScratchpadManageHook scratchpads <+> myManageHook <+> manageDocks <+> manageSpawn
      , startupHook = (if host == "desktop-arch" then desktopStartupHook else laptopStartupHook) <+> allStartupHook
      , handleEventHook =
          fixSteamFlicker
            <+> floatConfReqHook fixSteamFlickerMMMH
            <+> swallowEventHookSub (className =? "Alacritty" <||> className =? "kitty") (className /=? "kitty" <&&> className /=? "NNscratchpad")
      , logHook =
          updatePointer (0.5, 0.5) (0, 0)
            >> refocusLastLogHook
            >> nsHideOnFocusLoss scratchpads
      }
 where
  toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
  toggleStrutsKey XConfig{modMask = m} = (m, xK_b)
