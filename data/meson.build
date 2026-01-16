install_data ('10-enable-mount.rules',
    install_mode: 'rw-r--r--',
    install_dir: join_paths (get_option ('datadir'), 'polkit-1', 'rules.d')
)

gresource = gnome.compile_resources (
    'as-resources',
    'places.gresource.xml',
    source_dir: 'data',
    c_name: 'as'
)

install_data (
    'places.gschema.xml',
    install_dir: get_option('datadir') / 'glib-2.0' / 'schemas',
    rename: meson.project_name() + '.gschema.xml'
)
