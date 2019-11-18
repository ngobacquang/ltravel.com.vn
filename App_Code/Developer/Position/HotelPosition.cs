namespace Developer.Position
{
  public class HotelPosition
  {
    private string[] values;
    private string[] text;

    public HotelPosition()
    {
      text = new string[]
      {
                "Nhóm danh mục khách sạn trang chủ"
      };
      values = new string[]
      {
                "0"
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
