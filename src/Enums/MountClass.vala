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

public enum Places.MountClass {
    DEVICE,
    NETWORK,
    OTHER;

    public string to_icon () {
        switch (this) {
            case DEVICE: return "drive-harddisk";
            case NETWORK: return "folder-remote";
            default: return "folder";
        }
    }

    public string to_name () {
        switch (this) {
            case DEVICE: return _("Storage");
            case NETWORK: return _("Network");
            default: return _("Other");
        }
    }

    public static MountClass from_string (string kind) {
        switch (kind) {
            case "device": return DEVICE;
            case "network": return NETWORK;
            default: return OTHER;
        }        
    }
}
