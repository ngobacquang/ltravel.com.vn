using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for DealPosition
/// </summary>

namespace Developer.Position
{
    public class DealPosition
    {
        private string[] values;
        private string[] text;

        public DealPosition()
        {
            text = new string[]{"Nhóm hội thảo du học trang chủ"};
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
