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

    public partial class Form3 : Form
    {

        private NpgsqlConnection conn;
        private string connstring = String.Format("Server={0};Port={1};" +
            "User Id={2};Password={3};Database={4};",
            "localhost", 5432, "postgres",
            "123456", "betuls");
        private NpgsqlCommand cmd;
        private string sql = null;
        public Form3()
        {
            InitializeComponent();
        }

        private void Form3_Load(object sender, EventArgs e)
        {
            conn = new NpgsqlConnection(connstring);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            conn.Open();
            sql = @"SELECT*from istek_kitap_ekle(:isim,:yazar_adi,:kisi_no)";
            cmd = new NpgsqlCommand(sql, conn);

            cmd.Parameters.AddWithValue("isim", textBox1.Text);
            cmd.Parameters.AddWithValue("yazar_adi", textBox2.Text);
            cmd.Parameters.AddWithValue("kisi_no", textBox3.Text);

            int result = (int)cmd.ExecuteScalar();

            conn.Close();

            if (result == 1)
            {
                MessageBox.Show("Kitap ekleme işlemi başarılı!");
            }
        }
    }
}
