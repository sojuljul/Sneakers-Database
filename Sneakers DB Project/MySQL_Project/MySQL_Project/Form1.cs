using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace MySQL_Project
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        string connectionString = "server=127.0.0.1; database=sneakerdb; user=root; password=abc123";
        

        private void dataGrid_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {
            GridFill();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            
        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            using (MySqlConnection mysqlCon = new MySqlConnection(connectionString))
            {
                mysqlCon.Open();

                MySqlCommand mySqlCmd = new MySqlCommand("ShoeAdd", mysqlCon);
                mySqlCmd.CommandType = CommandType.StoredProcedure;

                mySqlCmd.Parameters.AddWithValue("_Shoe_id", textBox1.Text.Trim());
                mySqlCmd.Parameters.AddWithValue("_Shoe_name", textBox2.Text.Trim());
                mySqlCmd.Parameters.AddWithValue("_Release_date", textBox3.Text.Trim());
                mySqlCmd.Parameters.AddWithValue("_Retail_value", textBox4.Text.Trim());
                mySqlCmd.Parameters.AddWithValue("_SCompany_name", textBox5.Text.Trim());
                mySqlCmd.Parameters.AddWithValue("_SWebsite_id", textBox6.Text.Trim());

                mySqlCmd.Parameters.AddWithValue("_SCShoe_id", textBox1.Text.Trim());
                mySqlCmd.Parameters.AddWithValue("_SC_color", textBox7.Text.Trim());

                mySqlCmd.ExecuteNonQuery();
                MessageBox.Show("Submitted Successfully");
                Clear();
                GridFill();
            }
        }

        void GridFill()
        {
            using (MySqlConnection mysqlCon = new MySqlConnection(connectionString))
            {
                mysqlCon.Open();

                MySqlDataAdapter sqlDa = new MySqlDataAdapter("ShoeViewAll", mysqlCon);
                sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;

                DataTable dtblShoe = new DataTable();
                sqlDa.Fill(dtblShoe);

                dataGrid.DataSource = dtblShoe;

                dataGrid.Columns[4].Visible = false; // company name
                dataGrid.Columns[5].Visible = false; // website id

                dataGrid.Columns[1].Width = 350; // shoe name
                dataGrid.Columns[6].Width = 300; // shoe color
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            using (MySqlConnection mysqlCon = new MySqlConnection(connectionString))
            {
                mysqlCon.Open();

                MySqlDataAdapter sqlDa = new MySqlDataAdapter("ShoeSearch", mysqlCon);
                sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
                sqlDa.SelectCommand.Parameters.AddWithValue("_SearchValue", textBox8.Text);

                DataTable dtblShoe = new DataTable();
                sqlDa.Fill(dtblShoe);

                dataGrid.DataSource = dtblShoe;
                
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            GridFill();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void dataGrid_DoubleClick(object sender, EventArgs e)
        {
            // convert date to a different format
            DateTime dt = new DateTime();
            string strDate = dataGrid.CurrentRow.Cells[2].Value.ToString();
            dt = Convert.ToDateTime(strDate);
            string strDateCustom = dt.ToString("yyyy-MM-dd");

            if (dataGrid.CurrentRow.Index != -1)
            {
                textBox1.Text = dataGrid.CurrentRow.Cells[0].Value.ToString();
                textBox2.Text = dataGrid.CurrentRow.Cells[1].Value.ToString();
                textBox3.Text = strDateCustom; // date
                textBox4.Text = dataGrid.CurrentRow.Cells[3].Value.ToString();
                textBox5.Text = dataGrid.CurrentRow.Cells[4].Value.ToString();
                textBox6.Text = dataGrid.CurrentRow.Cells[5].Value.ToString();
                textBox7.Text = dataGrid.CurrentRow.Cells[6].Value.ToString();

                button2.Text = "Update";
            }
        }

        void Clear()
        {
            textBox1.Text = textBox2.Text = textBox3.Text = textBox4.Text = textBox5.Text = textBox6.Text = textBox7.Text = "";
            button2.Text = "Insert";
        }

        private void button1_Click_1(object sender, EventArgs e)
        {
            Clear();
        }

        private void button5_Click(object sender, EventArgs e)
        {
            using (MySqlConnection mysqlCon = new MySqlConnection(connectionString))
            {
                mysqlCon.Open();

                MySqlCommand mySqlCmd = new MySqlCommand("ShoeColorDelete", mysqlCon);
                mySqlCmd.CommandType = CommandType.StoredProcedure;

                mySqlCmd.Parameters.AddWithValue("_Shoe_id", textBox1.Text.Trim());

                mySqlCmd.ExecuteNonQuery();
                MessageBox.Show("Delete Successfully");
                Clear();
                GridFill();
            }
        }
    }
}
