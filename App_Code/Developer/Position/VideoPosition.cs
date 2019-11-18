using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for VideoPosition
/// </summary>

namespace Developer.Position
{
    public class VideoPosition
    {
        private string[] values;
        private string[] text;

        public VideoPosition()
        {
            text = new string[]{"Nhóm video tại trang chủ"};
            values = new string[] {"0"};
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
