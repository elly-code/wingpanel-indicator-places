/*
 * Copyright (c) 2018 Dirli <litandrej85@gmail.com>
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
    public class MountItem : ListItem {
        private GLib.Mount mount;

        public MountItem (GLib.Mount mount, Places.MountClass mount_class) {
            base (mount.get_name (), mount_class.to_icon (), mount.get_icon ());

            category_name = mount_class.to_name ();
            this.mount = mount;

            var unmount_button = new Gtk.Button.from_icon_name ("media-eject-symbolic", Gtk.IconSize.MENU) {
                relief = Gtk.ReliefStyle.NONE,
                can_focus = false,
                halign = Gtk.Align.END
            };

            unmount_button.clicked.connect (on_button_clicked);

            if (mount.can_eject ()) {
                unmount_button.tooltip_text = _("Eject %s").printf (mount.get_name ());
            } else {
                unmount_button.tooltip_text = _("Unmount %s").printf (mount.get_name ());
            }

            overlay.add_overlay (unmount_button);
        }

        private void on_button_clicked () {
            if (mount.can_eject ()) {
                do_eject ();
            } else {
                do_unmount ();
            }
        }

        /*
         * Ejects a mount
         */
        private void do_eject () {
            mount.eject_with_operation.begin (GLib.MountUnmountFlags.NONE, null, null, on_eject);
        }

        private void on_eject (GLib.Object? obj, GLib.AsyncResult res) {
            try {
                mount.eject_with_operation.end (res);
            } catch (GLib.Error e) {
                warning (_("Error while ejecting device"));
                warning (e.message);
            }
        }
        /*
         * Unmounts a mount
         */
        private void do_unmount () {
            mount.unmount_with_operation.begin (GLib.MountUnmountFlags.NONE, null, null, on_unmount);
        }

        private void on_unmount (GLib.Object? obj, GLib.AsyncResult res) {
            try {
                mount.unmount_with_operation.end (res);
            } catch (GLib.Error e) {
                warning (_("Error while unmounting volume"));
                warning (e.message);
            }
        }
    }
}
