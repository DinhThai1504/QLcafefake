using QLQuanCafe.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace QLQuanCafe.DAO
{
    public class BillinfoDAO
    {
        private static BillinfoDAO instance;

        public static BillinfoDAO Instance
        {
            get { if (instance == null) instance = new BillinfoDAO(); return BillinfoDAO.instance; }
            private set { BillinfoDAO.instance = value; }
        }

        private BillinfoDAO() { }


        public List<Billinfo> GetListBillinfo(int id)
        {
            List<Billinfo> listBillinfo = new List<Billinfo>();
            string query = "SELECT * FROM dbo.BillInfo WHERE idBill = " + id;
            System.Data.DataTable data = DataProvider.Instance.ExecuteQuery(query);
            foreach (System.Data.DataRow item in data.Rows)
            {
                Billinfo info = new Billinfo(item);
                listBillinfo.Add(info);
            }
            return listBillinfo;
        }

        public void InsertBillInfo(int idBill, int idFood, int count)
        {
            DataProvider.Instance.ExecuteNonQuery("USP_InsertBillInfo @idBill , @idFood , @count", new object[] { idBill, idFood, count });
            
        }
    }
}
