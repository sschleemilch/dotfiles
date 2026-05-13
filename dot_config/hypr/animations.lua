hl.curve('myBezier', { type = 'bezier', points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.animation({
  leaf = 'windows',
  enabled = true,
  speed = 4,
  bezier = 'myBezier',
  stlye = 'popin',
})

hl.animation({
  leaf = 'workspaces',
  enabled = true,
  speed = 4,
  bezier = 'myBezier',
  stlye = 'slidevert',
})

hl.animation({
  leaf = 'fade',
  enabled = true,
  speed = 4,
  bezier = 'myBezier',
})

hl.animation({
  leaf = 'layers',
  enabled = true,
  speed = 4,
  bezier = 'myBezier',
  style = 'fade',
})
