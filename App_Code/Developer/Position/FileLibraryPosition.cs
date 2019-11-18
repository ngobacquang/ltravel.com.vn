using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for FileLibraryPosition
/// </summary>

namespace Developer.Position
{
    public class FileLibraryPosition
    {
        private string[] values;
        private string[] text;

        public FileLibraryPosition()
        {
            text = new string[]{"Nhóm học bổng du học trang chủ"};
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
