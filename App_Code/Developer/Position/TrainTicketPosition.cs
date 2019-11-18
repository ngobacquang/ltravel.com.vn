using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for TrainTicketPosition
/// </summary>

namespace Developer.Position
{
    public class TrainTicketPosition
    {
        private string[] values;
        private string[] text;

        public TrainTicketPosition()
        {
            text = new string[]{"Nhóm 1", "Nhóm 2", "Nhóm 3"};
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
