using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for PhotoAlbumPosition
/// </summary>

namespace Developer.Position
{
    public class PhotoAlbumMemberPosition
    {
        private string[] values;
        private string[] text;

        public PhotoAlbumMemberPosition()
        {
            text = new string[]{"Nhóm album 1", "Nhóm album 2", "Nhóm album 3"};
            values = new string[] {"0","1","2"};
        }
        public string[] Text
        {
            get { return text; }
        }
        public string[] Values
        {
            get { return values; }
        }
    }
}
