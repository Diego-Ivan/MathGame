mathgame_sources = [
  'main.vala',
  'application.vala',
  'window.vala',

  'Operation.vala',
  'Exercise.vala',
]

mathgame_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.4'),
]

mathgame_sources += gnome.compile_resources('mathgame-resources',
  'mathgame.gresource.xml',
  c_name: 'mathgame'
)

executable('mathgame', mathgame_sources,
  dependencies: mathgame_deps,
       install: true,
)
