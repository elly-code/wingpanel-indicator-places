project(
  'wingpanel-indicator-places',
  'vala', 'c',
  version: '3.2.0'
)

gnome = import ('gnome')
i18n = import ('i18n')
gettext_name = meson.project_name ()

prefix = get_option('prefix')
libdir = prefix / get_option('libdir')


add_global_arguments ('-DGETTEXT_PACKAGE="@0@"'.format (gettext_name), language:'c')

wingpanel_dep = dependency ('wingpanel')

subdir ('data')

config_data = configuration_data()
config_data.set_quoted('LOCALEDIR', prefix / get_option('localedir'))
config_data.set_quoted('GETTEXT_PACKAGE', meson.project_name())
config_data.set_quoted('DATADIR', prefix / get_option('datadir') / meson.project_name())
config_file = configure_file(
    input: 'src/Config.vala.in',
    output: '@BASENAME@',
    configuration: config_data
)

shared_module (
  meson.project_name (),
  configure_file(input: 'src/Config.vala.in', output: '@BASENAME@', configuration: config_data),
  'src/Indicator.vala',
  'src/Widgets/BookmarksItem.vala',
  'src/Widgets/ListItem.vala',
  'src/Widgets/MountItem.vala',
  'src/Widgets/Popover.vala',
  'src/Widgets/VolumeItem.vala',
  'src/Widgets/StandardItem.vala',
  'src/Enums/MountClass.vala',
  'src/Enums/StandardPlaces.vala',
  'src/Utils.vala',
  gresource,
  dependencies: [
    dependency ('glib-2.0'),
    dependency ('gobject-2.0'),
    dependency ('granite'),
    dependency ('gtk+-3.0'),
    wingpanel_dep
  ],
  install: true,
  install_dir : wingpanel_dep.get_variable ('indicatorsdir')
)

subdir ('po')

gnome.post_install(glib_compile_schemas: true)
