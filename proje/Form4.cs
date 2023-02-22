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
    public partial class Form4 : Form
    {
        private NpgsqlConnection conn;
        private string connstring = String.Format("Server={0};Port={1};" +
            "User Id={2};Password={3};Database={4};",
            "localhost", 5432, "postgres",
            "123456", "betuls");
        private NpgsqlCommand cmd;
        private string sql = null;
        public Form4()
        {
            InitializeComponent();
        }

        private void Form4_Load(object sender, EventArgs e)
        {
            conn = new NpgsqlConnection(connstring);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            conn.Open();
            sql = @"SELECT*from sifre_guncelle(:kullanıcı_no, :yeni_sifre)";
            cmd = new NpgsqlCommand(sql, conn);

            cmd.Parameters.AddWithValue("kullanıcı_no", textBox1.Text);
            cmd.Parameters.AddWithValue("yeni_sifre", textBox2.Text);

            NpgsqlDataAdapter da = new NpgsqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;

            int result = (int)cmd.ExecuteScalar();

            conn.Close();

            if (result == 1)
            {
                MessageBox.Show("Şifre güncelleme başarılı!");
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
            Application.Exit();
        }
    }
}
