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

public enum Places.StandardPlaces {
    HOME,
    COMPUTER,
    ROOT,
    RECENT,
    NETWORK,
    TRASH;

    public const StandardPlaces[] CHOICES = {
        HOME, ROOT, RECENT, NETWORK, TRASH
    };

    public string to_icon () {
        switch (this) {
            case HOME: return "user-home";
            case COMPUTER: return "computer";
            case ROOT: return "drive-harddisk";
            case RECENT: return "document-open-recent";
            case NETWORK: return "network-workgroup";
            case TRASH: return "user-trash";
            default: return "folder";
        }
    }

    public string to_name () {
        switch (this) {
            case HOME: return _("Home Folder");
            case COMPUTER: return _("Computer");
            case ROOT: return _("Root");
            case RECENT: return _("Recent");
            case NETWORK: return _("Network");
            case TRASH: return _("Trash");
            default: return _("Unknown");
        }
    }

    public string to_path () {
        switch (this) {
            case HOME: return "file:" + GLib.Environment.get_home_dir ();
            case COMPUTER: return "computer:///";
            case ROOT: return "file:///";
            case RECENT: return "recent:///";
            case NETWORK: return "network:///";
            case TRASH: return "trash:///";
            default: return "file:///";
        }
    }
}
