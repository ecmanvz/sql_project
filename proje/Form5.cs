using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;

namespace proje
{
    public partial class Form5 : Form
    {
        private NpgsqlConnection conn;
        private string connstring = String.Format("Server={0};Port={1};" +
            "User Id={2};Password={3};Database={4};",
            "localhost", 5432, "postgres",
            "123456", "betuls");
        private NpgsqlCommand cmd;
        private string sql = null;
        public Form5()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            conn.Open();
            sql = @"SELECT*from oduncAl(:_isim,:_raf)";
            cmd = new NpgsqlCommand(sql, conn);

            cmd.Parameters.AddWithValue("_isim", textBox1.Text);
            cmd.Parameters.AddWithValue("_raf", textBox1.Text);

            int result = (int)cmd.ExecuteScalar();

            conn.Close();

            if(result==1)
            {
                MessageBox.Show("ödünç alma işlemi başarılı!");
                sql = @"SELECT*from rafGüncelle()";

                MessageBox.Show("raf güncelleme işlemi başarılı!");
            }
            else
            {
                MessageBox.Show("istediğiniz kitap bulunmuyor!");
                this.Hide();
                new Form2(textBox1.Text).Show();
                return;
            }

            
        }

        private void Form5_Load(object sender, EventArgs e)
        {
            conn = new NpgsqlConnection(connstring);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
            Application.Exit();
        }
    }
}
