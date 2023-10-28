mathgame_sources = [
  'main.vala',
  'application.vala',
  'window.vala',

  'Operation.vala',
  'Exercise.vala',
  'ExerciseGenerator.vala',

  # Services
  'Services/Settings.vala',

  # Views
  'Views/StartView.vala',
  'Views/GameView.vala',
]

blueprints = custom_target('blueprints',
  build_always_stale: true,
  input: files(
    'gtk/help-overlay.blp',
    'gtk/start-view.blp',
    'gtk/game-view.blp',
    'window.blp',
  ),
  output: '.',
  command: [find_program('blueprint-compiler'), 'batch-compile', '@OUTPUT@', '@CURRENT_SOURCE_DIR@', '@INPUT@'],
)

mathgame_deps = [
  dependency('gtk4'),
  dependency('libadwaita-1', version: '>= 1.4'),
]

mathgame_sources += gnome.compile_resources('mathgame-resources',
  'mathgame.gresource.xml',
  dependencies: blueprints,
  c_name: 'mathgame'
)

executable('mathgame', mathgame_sources,
  vala_args: [
    '--gresourcesdir=src/',
  ],
  dependencies: mathgame_deps,
       install: true,
)
