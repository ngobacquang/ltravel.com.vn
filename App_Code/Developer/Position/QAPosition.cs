using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for QAPosition
/// </summary>

namespace Developer.Position
{
    public class QAPosition
    {
        private string[] values;
        private string[] text;

        public QAPosition()
        {
            text = new string[]{"Nhóm ý kiến khách hàng trang chủ"};
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
