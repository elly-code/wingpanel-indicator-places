/*
 * Copyright (c) 2018-2020 Dirli <litandrej85@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

namespace Places.Widgets {
    public class Popover : Gtk.Box {

        private string user_home;
        private Gtk.ListBox user_listbox;
        private Gtk.ListBox std_listbox;
        private Gtk.ListBox vol_listbox;

        public signal void close_popover ();

        public Popover () {
            hexpand = true;
            orientation = Gtk.Orientation.HORIZONTAL;
            spacing = 0;


            user_home = GLib.Environment.get_home_dir ();

            user_listbox = new Gtk.ListBox ();
            user_listbox.set_selection_mode (Gtk.SelectionMode.NONE);
            user_listbox.set_header_func (list_header_func);

            std_listbox = new Gtk.ListBox ();
            std_listbox.set_selection_mode (Gtk.SelectionMode.NONE);
            std_listbox.set_header_func (list_header_func);
            std_listbox.vexpand = false;

            vol_listbox = new Gtk.ListBox ();
            vol_listbox.set_selection_mode (Gtk.SelectionMode.NONE);
            vol_listbox.set_header_func (list_header_func);

            Gtk.Separator v_separator = new Gtk.Separator (Gtk.Orientation.VERTICAL);
            v_separator.margin_start = v_separator.margin_end = 10;

            add_std_places ();
            add_user_places ();

            var left_pane = new Gtk.Box (VERTICAL, 10) {
                margin_top = 10,
                margin_bottom = 10,
                margin_end = 10,
                margin_start = 10,
                hexpand = vexpand = true
            };

            left_pane.pack_start (std_listbox);
            left_pane.pack_start (vol_listbox);
            //attach (std_listbox, 0, 0, 1, 1);
            //attach (vol_listbox, 0, 1, 1, 1);
            //attach (v_separator, 1, 0, 1, 2);
            //attach (user_listbox, 2, 0, 1, 2);


            var right_pane = new Gtk.Box (VERTICAL, 10) {
                margin_top = 10,
                margin_bottom = 10,
                margin_end = 10,
                margin_start = 10,
                hexpand = vexpand = true
            };

            right_pane.pack_start (user_listbox);

            pack_start (left_pane);
            pack_start (v_separator);
            pack_start (right_pane);
            show_all ();
        }

        public void add_std_places () {
            ListItem iter = new StandardItem (_("Home Folder"), "user-home");
            iter.tooltip_text = "file:" + user_home;
            iter.iter_button.clicked.connect (() => {open_directory (file_from_path ("file:" + user_home));});
            std_listbox.add (iter);

            // iter = new ListItem (_("Computer"), "computer");
            //iter.tooltip_text = "computer:///";
            // iter.iter_button.clicked.connect (() => {open_directory (file_from_path ("computer:///"));});
            // std_listbox.add (iter);

            iter = new StandardItem (_("Root"), "computer");
            iter.tooltip_text = "file:///";
            iter.iter_button.clicked.connect (() => {open_directory (file_from_path ("file:///"));});
            std_listbox.add (iter);

            iter = new StandardItem (_("Recent"), "document-open-recent");
            iter.tooltip_text = "recent:///";
            iter.iter_button.clicked.connect (() => {open_directory (file_from_path ("recent:///"));});
            std_listbox.add (iter);

            iter = new StandardItem (_("Network"), "network-workgroup");
            iter.tooltip_text = "network:///";
            iter.iter_button.clicked.connect (() => {open_directory (file_from_path ("network:///"));});
            std_listbox.add (iter);

            iter = new StandardItem (_("Trash"), "user-trash");
            iter.tooltip_text = "trash:///";
            iter.iter_button.clicked.connect (() => {open_directory (file_from_path ("trash:///"));});
            std_listbox.add (iter);
        }

        private void add_user_places () {
            string bookmarks_filename = GLib.Path.build_filename (user_home, ".config", "gtk-3.0", "bookmarks", null);
            GLib.File bookmarks_file = GLib.File.new_for_path (bookmarks_filename);

            if (!bookmarks_file.query_exists ()) {
                return;
            }

            try {
                var dis = new DataInputStream (bookmarks_file.read ());
                string line;

                while ((line = dis.read_line (null)) != null) {
                    string path = line.split (" ")[0];
                    var file = File.new_for_uri (path);
                    string label = file.get_basename ();

                    if (label == "/") {
                        label = line.split (" ")[1];
                    }

                    BookmarksItem iter = new BookmarksItem (label, Utils.get_user_icon (path));
                    iter.iter_button.clicked.connect (() => {open_directory (file_from_path (path));});
                    iter.set_tooltip_text (path);
                    user_listbox.add (iter);
                }
            } catch (GLib.Error error) {
                warning (error.message);
            }
        }

        private GLib.File? file_from_path (string path) {
            string place = path.split (" ")[0];
            string unescaped_path = GLib.Uri.unescape_string (place);
            GLib.File file = GLib.File.new_for_uri (unescaped_path);
            return file;
        }

        private void open_directory (GLib.File? file) {
            if (file == null) {
                return;
            }

            close_popover ();

            GLib.AppLaunchContext launch_context = Gdk.Display.get_default ().get_app_launch_context ();
            GLib.List<GLib.File> file_list = new GLib.List<GLib.File> ();
            file_list.append (file);

            try {
                GLib.AppInfo.get_default_for_type ("inode/directory", true).launch (file_list, launch_context);
            } catch (GLib.Error e) {
                warning (e.message);
            }
        }

        private void list_header_func (Gtk.ListBoxRow? before, Gtk.ListBoxRow? after) {
            ListItem? child = null;
            string? prev = null;
            string? next = null;

            if (before != null) {
                child = before.get_child () as ListItem;
                prev = child.get_item_category ();
            }

            if (after != null) {
                child = after.get_child () as ListItem;
                next = child.get_item_category ();
            }

            if (before == null || after == null || prev != next) {
                var label = new Gtk.Label (prev) {
                    margin_start = 5,
                    margin_end = 5,
                    margin_top = 5,
                    margin_bottom = 10,
                    halign = Gtk.Align.CENTER
                };
                label.get_style_context ().add_class (Granite.STYLE_CLASS_H3_LABEL);
                before.set_header (label);

            } else {
                before.set_header (null);
            }
        }

        public void clear_volumes () {
            foreach (Gtk.Widget item in vol_listbox.get_children ()) {
                item.destroy ();
            }
        }

        public void add_volume (GLib.Volume volume) {
            VolumeItem volume_item = new VolumeItem (volume);
            volume_item.mount_done.connect ((file) => {
                open_directory (file);
            });

            vol_listbox.add (volume_item);
        }

        public void add_mount (GLib.Mount mount, Places.MountClass mount_class) {
            MountItem mount_item = new MountItem (mount, mount_class);
            mount_item.iter_button.clicked.connect (() => {
                open_directory (mount.get_root ());
            });

            vol_listbox.add (mount_item);
        }
    }
}
