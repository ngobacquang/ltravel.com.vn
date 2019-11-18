using System;
namespace TatThanhJsc.Extension
{
    /// <summary>
    /// Thực hiện các công việc liên quan đến thời gian (như định dạnh thời gian)
    /// </summary>
    public class TimeExtension
    {
        /// <summary>
        /// Định dạng thời gian
        /// </summary>
        /// <param name="time">Đối tượng chứa thời gian</param>
        /// <param name="type_datetime">Định dạng cho thời gian (vd:"MM/dd/yyyy")</param>
        /// <returns></returns>
        public static string FormatTime(object time,string type_datetime)
        {
            try
            {
                string s = "";
                if (!time.Equals("") || time != null)
                {
                    s = ((DateTime)time).ToString(type_datetime);
                }
                return s;
            }
            catch (Exception)
            {
                return "";
                throw;
            }
        }

        /// <summary>
        /// Định dạng thời gian theo một số lựa chọn sẵn
        /// </summary>
        /// <param name="time">Đối tượng chứa thời gian</param>
        /// <param name="typeFormat">1: MM/dd/yyyy, 2: dd/MM/yyyy, 3: MM/yyyy, 4: dd/MM, 5: MM/dd/yyyy hh:mm:ss tt, 6: dd/MM/yyyy hh:mm:ss tt</param>
        /// <returns></returns>
        public static string FormatTime(object time, int typeFormat)
        {
            string s = "";
            try
            {
                switch (typeFormat)
                {
                    case 1:
                        s = ((DateTime)time).ToString("MM/dd/yyyy");
                        break;
                    case 2:
                        s = ((DateTime)time).ToString("dd/MM/yyyy");
                        break;
                    case 3:
                        s = ((DateTime)time).ToString("MM/yyyy");
                        break;
                    case 4:
                        s = ((DateTime)time).ToString("dd/MM");
                        break;
                    case 5:
                        s = ((DateTime)time).ToString("MM/dd/yyyy hh:mm:ss tt");
                        break;
                    case 6:
                        s = ((DateTime)time).ToString("dd/MM/yyyy hh:mm:ss tt");
                        break;
                    default:
                        s = ((DateTime)time).ToString("MM/dd/yyyy");
                        break;
                }
            }
            catch { }
            return s;
        }
    }
}