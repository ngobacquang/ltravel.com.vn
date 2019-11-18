using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for ContentPosition
/// </summary>

namespace Developer.Position
{
    public class ContentPosition
    {
        private string[] values;
        private string[] text;

        public ContentPosition()
        {
            text = new string[]
                       {
                           "Thông báo quan trọng", "Tin hot", "Vị trí số 3"
                       };
            values = new string[] { 
                "0","1","2"};
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
