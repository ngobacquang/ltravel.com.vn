
using System.Configuration;
using System.Xml;

namespace TatThanhJsc.Extension
{
    public class PriceExtension
    {
        /// <summary>
        /// Lấy giá khi đặt hàng. Nếu có giá khuyến mại --> lấy giá khuyến mại, nếu không thì lấy giá niêm yết
        /// </summary>
        /// <param name="giaNY"></param>
        /// <param name="giaKM"></param>
        /// <returns></returns>
        public static double LayGiaDatHang(double giaNY, double giaKM)
        {
            if (giaKM>0)
                return giaKM;
            return giaNY;
        }

        /// <summary>
        /// Hiển thị giá niêm yết, giá khuyến mại. Nếu không có giá khuyến mại thì chỉ hiển thị giá niêm yết
        /// </summary>
        /// <param name="giaNY">dt.Rows[i][ItemsColumns.FipriceColumn].ToString()</param>
        /// <param name="giaKM">dt.Rows[i][ItemsColumns.FisalepriceColumn].ToString()</param>
        /// <returns></returns>
        public static string HienThiGia(string giaNY, string giaKM)
        {
            string s = "";
            if (giaKM != "0")
            {
                s += "<span class='giaKM'>" +
                     NumberExtension.FormatNumber(giaKM, true, LanguageItemExtension.GetnLanguageItemTitleByName("liên hệ"), LanguageItemExtension.GetnLanguageItemTitleByName("đ")) +
                     "</span>";
                s += " <span class='giaNY'>" +
                   NumberExtension.FormatNumber(giaNY, true, LanguageItemExtension.GetnLanguageItemTitleByName("liên hệ"), LanguageItemExtension.GetnLanguageItemTitleByName("đ")) +
                   "</span>";
            }
            else
                s = "<span class='giaKM'>" +
                    NumberExtension.FormatNumber(giaNY, true, LanguageItemExtension.GetnLanguageItemTitleByName("liên hệ"), LanguageItemExtension.GetnLanguageItemTitleByName("đ")) +
                    "</span>";
            return s;
        }

        /// <summary>
        /// Hiển thị giá niêm yết, giá khuyến mại. Nếu không có giá khuyến mại thì chỉ hiển thị giá niêm yết, có cho gạch ngang giá cũ
        /// </summary>
        /// <param name="giaNY">dt.Rows[i][ItemsColumns.FipriceColumn].ToString()</param>
        /// <param name="giaKM">dt.Rows[i][ItemsColumns.FisalepriceColumn].ToString()</param>
        /// <returns></returns>
        public static string HienThiGia02(string giaNY, string giaKM)
        {
            string s = "";
            if (ConfigurationManager.AppSettings["amegatour3"] != null)
            {
                if (giaKM != "0")
                {
                    s += "<span class='giaKM'>" +
                         NumberExtension.FormatNumber(giaKM, true, LanguageItemExtension.GetnLanguageItemTitleByName("contact"), LanguageItemExtension.GetnLanguageItemTitleByName("$")).Replace(" ", "") +
                         "</span>";
                    s += " <span class='giaNY' style='text-decoration:line-through'>" +
                       NumberExtension.FormatNumber(giaNY, true, LanguageItemExtension.GetnLanguageItemTitleByName("contact"), LanguageItemExtension.GetnLanguageItemTitleByName("$")).Replace(" ", "") +
                       "</span>";
                }
                else
                    s = "<span class='giaKM'>" +
                        NumberExtension.FormatNumber(giaNY, true, LanguageItemExtension.GetnLanguageItemTitleByName("contact"), LanguageItemExtension.GetnLanguageItemTitleByName("$")).Replace(" ", "") +
                        "</span>";
            }
            else
            {
                if (giaKM != "0")
                {
                    s += "<span class='giaKM'>" + LanguageItemExtension.GetnLanguageItemTitleByName("$") +
                         NumberExtension.FormatNumber(giaKM, true,
                             LanguageItemExtension.GetnLanguageItemTitleByName("contact"), "") +
                         "</span>";
                    s += "<span class='giaNY' style='text-decoration:line-through'>" +
                         LanguageItemExtension.GetnLanguageItemTitleByName("$") +
                         NumberExtension.FormatNumber(giaNY, true,
                             LanguageItemExtension.GetnLanguageItemTitleByName("contact"), "") +
                         "</span>";
                }
                else
                    s = "<span class='giaKM'>" + LanguageItemExtension.GetnLanguageItemTitleByName("$") +
                        NumberExtension.FormatNumber(giaNY, true,
                            LanguageItemExtension.GetnLanguageItemTitleByName("contact"), "") +
                        "</span>";
            }
            return s;
        }


        /// <summary>
        /// Tính ra % giảm giá
        /// </summary>
        /// <param name="giaNY"></param>
        /// <param name="giaKM"></param>
        /// <returns></returns>
        public static double TinhPhanTramGiam(string giaNY, string giaKM)
        {
            try
            {
                double giaGiam = double.Parse(giaKM);
                double giaGoc = double.Parse(giaNY);

                return (giaGoc - giaGiam)/giaGoc*100;
            }
            catch
            {
                return 0;
            }            
        }

        #region Lấy tỷ giá chuyển đổi nếu tiền trên web dùng không phải VND (vì tích hợp thanh toán onepay chỉ cho sửa dụng VND). Tỷ giá lấy theo https://www.vietcombank.com.vn/ExchangeRates/ExrateXML.aspx
        public static double LayTyGia(string currency)
        {
            double s = 1;

            //Thử ở cả link có https và không có
            try
            {
                XmlDocument xml = new XmlDocument();
                xml.Load("http://www.vietcombank.com.vn/ExchangeRates/ExrateXML.aspx");

                XmlNodeList xnList = xml.SelectNodes("/ExrateList/Exrate [@CurrencyCode='" + currency + "']");
                foreach (XmlNode xn in xnList)
                {
                    s = double.Parse(xn.Attributes["Transfer"].InnerText);
                }
            }
            catch { }

            try
            {
                XmlDocument xml = new XmlDocument();
                xml.Load("https://www.vietcombank.com.vn/ExchangeRates/ExrateXML.aspx");

                XmlNodeList xnList = xml.SelectNodes("/ExrateList/Exrate [@CurrencyCode='" + currency + "']");
                foreach (XmlNode xn in xnList)
                {
                    s = double.Parse(xn.Attributes["Transfer"].InnerText);
                }
            }
            catch {}
            return s;
        }
        #endregion
    }
}