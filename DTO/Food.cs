using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLQuanCafe.DTO
{
    public class Food
    {
        private int iD;
        private string name;
        private int idCategory;
        private float price;
        public Food(int iD, string name, int idCategory, float price)
        {
            this.ID = iD;
            this.Name = name;
            this.IdCategory = idCategory;
            this.Price = price;
        }
        public Food(System.Data.DataRow row)
        {
            this.ID = (int)row["id"];
            this.Name = row["name"].ToString();
            this.IdCategory = (int)row["idCategory"];
            this.Price = (float)Convert.ToDouble(row["price"].ToString());
        }
        public int ID
        {
            get { return iD; }
            set { iD = value; }
        }
        public string Name
        {
            get { return name; }
            set { name = value; }
        }
        public int IdCategory
        {
            get { return idCategory; }
            set { idCategory = value; }
        }
        public float Price
        {
            get { return price; }
            set { price = value; }
        }
    }
}
