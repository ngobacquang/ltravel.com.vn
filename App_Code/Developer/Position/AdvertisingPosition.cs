/// <summary>
/// Summary description for ContentPosition
/// </summary>

namespace Developer.Position
{
  public class AdvertisingPosition
  {
    private string[] values;
    private string[] text;

    public AdvertisingPosition()
    {
      text = new string[]
      {
        "Logo",
        "Slide chính tại trang chủ",
        "Các mạng xã hội đầu trang",
        "Nhóm giới thiệu trang chủ"
      };
      values = new string[]
      {
        "0",//"Logo",
        "1",//"Slide chính tại trang chủ",         
        "2",//"Các mạng xã hội đầu trang"
        "3"//"Nhóm giới thiệu trang chủ"
      };
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

