require('monitors')
require('animations')

local colors = require('colorscheme')

hl.config({
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    disable_xdg_env_checks = true,
  },
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    col = {
      active_border = colors.border_active,
      inactive_border = colors.border_inactive,
    },
    resize_on_border = true,
  },
  decoration = {
    rounding = 12,
  },
  dwindle = {
    preserve_split = true,
  },
  input = {
    kb_layout = 'de',
    touchpad = {
      natural_scroll = true,
    },
  },
})

hl.on('hyprland.start', function()
  hl.exec_cmd('hyprpaper')
  hl.exec_cmd('systemctl --user start hyprpolkitagent')
  hl.exec_cmd('quickshell')
end)

hl.gesture({
  fingers = 3,
  direction = 'horizontal',
  action = 'workspace',
})

local mainMod = 'SUPER'

hl.bind(mainMod .. ' + SPACE', hl.dsp.exec_cmd('fuzzel'))
hl.bind(mainMod .. ' + escape', hl.dsp.exec_cmd('hyprlock'))
hl.bind(mainMod .. ' + S', hl.dsp.exec_cmd('grimblast save area'))
hl.bind(mainMod .. ' + Q', hl.dsp.window.close())

hl.bind('F11', hl.dsp.window.fullscreen())

hl.bind(mainMod .. ' + h', hl.dsp.focus({ direction = 'left' }))
hl.bind(mainMod .. ' + l', hl.dsp.focus({ direction = 'right' }))
hl.bind(mainMod .. ' + k', hl.dsp.focus({ direction = 'up' }))
hl.bind(mainMod .. ' + j', hl.dsp.focus({ direction = 'down' }))

hl.bind(mainMod .. '+ SHIFT + h', hl.dsp.window.move({ direction = 'left' }))
hl.bind(mainMod .. '+ SHIFT + l', hl.dsp.window.move({ direction = 'right' }))
hl.bind(mainMod .. '+ SHIFT + k', hl.dsp.window.move({ direction = 'up' }))
hl.bind(mainMod .. '+ SHIFT + j', hl.dsp.window.move({ direction = 'down' }))

for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. ' + ' .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. ' + SHIFT + ' .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. ' + CTRL + H', hl.dsp.focus({ workspace = 'e-1' }))
hl.bind(mainMod .. ' + CTRL + L', hl.dsp.focus({ workspace = 'e+1' }))

hl.bind(mainMod .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true })

hl.bind(
  'XF86AudioRaiseVolume',
  hl.dsp.exec_cmd('wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+'),
  { locked = true, repeating = true }
)
hl.bind(
  'XF86AudioLowerVolume',
  hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-'),
  { locked = true, repeating = true }
)
hl.bind(
  'XF86AudioMute',
  hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'),
  { locked = true, repeating = true }
)
hl.bind(
  'XF86AudioMicMute',
  hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle'),
  { locked = true, repeating = true }
)
hl.bind('XF86MonBrightnessUp', hl.dsp.exec_cmd('brightnessctl -e4 -n2 set 5%+'), { locked = true, repeating = true })
hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd('brightnessctl -e4 -n2 set 5%-'), { locked = true, repeating = true })
