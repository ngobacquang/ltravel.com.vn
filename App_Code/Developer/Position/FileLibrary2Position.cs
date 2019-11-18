using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for FileLibrary2Position
/// </summary>

namespace Developer.Position
{
    public class FileLibrary2Position
    {
        private string[] values;
        private string[] text;

        public FileLibrary2Position()
        {
            text = new string[]{"Nhóm dữ liệu 1", "Nhóm dữ liệu 2", "Nhóm dữ liệu 3"};
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
