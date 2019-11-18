namespace Developer.Position
{
  public class TourPosition
  {
    private string[] values;
    private string[] text;

    public TourPosition()
    {
      text = new string[]
      {
        "Nhóm tour trang chủ"
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
