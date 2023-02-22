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
    public partial class Form2 : Form
    {
        private NpgsqlConnection conn;
        private string connstring = String.Format("Server={0};Port={1};" +
            "User Id={2};Password={3};Database={4};",
            "localhost", 5432, "postgres",
            "123456", "betuls");
        private NpgsqlCommand cmd;
        private string sql = null;
        public Form2(string username)
        {
            this.username = username;
            InitializeComponent();
        }
        private string username;

        private void Form2_Load(object sender, EventArgs e)
        {
            conn = new NpgsqlConnection(connstring);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            conn.Open();
            sql = @"SELECT*from ara(:isim)";
            cmd = new NpgsqlCommand(sql, conn);

            cmd.Parameters.AddWithValue("isim", textBox1.Text);
            NpgsqlDataAdapter da = new NpgsqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
            conn.Close();


        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Hide();
            Form3 f3 = new Form3();
            f3.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Close();
            Application.Exit();

        }

        private void button4_Click(object sender, EventArgs e)
        {

            this.Hide();
            Form5 f5 = new Form5();
            f5.Show();
            
        }
    }
}
