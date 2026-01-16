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
    public class ListItem : Gtk.Box {

        public Gtk.ToolButton iter_button;
        protected Gtk.Box inner_box;
        protected string? category_name = null;

        public ListItem (string elem_label, string elem_img, GLib.Icon? elem_icon = null) {
            orientation = Gtk.Orientation.HORIZONTAL;
            margin_bottom = 5;
            hexpand = true;
            valign = Gtk.Align.CENTER;

            iter_button = new Gtk.ToolButton (null, null);
            iter_button.set_can_focus (false);

            pack_start (iter_button, true, true, 0);

            Gtk.Image icon;
            if (elem_icon != null) {
                icon = new Gtk.Image.from_gicon (elem_icon, Gtk.IconSize.MENU);
            } else {
                icon = new Gtk.Image ();
                icon.set_from_icon_name (elem_img, Gtk.IconSize.MENU);
            }
            icon.margin_end = 5;

            Gtk.Label label = new Gtk.Label (elem_label) {
                max_width_chars = 25,
                ellipsize = Pango.EllipsizeMode.END,
                halign = Gtk.Align.START
            };

            inner_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
            inner_box.pack_start (icon, false, false, 0);
            inner_box.pack_start (label, true, true, 0);

            iter_button.set_label_widget (inner_box);
        }

        public string get_item_category () {
            if (category_name != null) {
                return category_name;
            } else {
                return "";
            }
        }
    }
}
