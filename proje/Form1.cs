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
    public partial class Form1 : Form
    {
        private NpgsqlConnection conn;
        private string connstring = String.Format("Server={0};Port={1};" +
            "User Id={2};Password={3};Database={4};",
            "localhost", 5432, "postgres",
            "123456", "betuls");
        private NpgsqlCommand cmd;
        private string sql = null;
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            conn = new NpgsqlConnection(connstring);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                conn.Open();
                sql = @"SELECT*from u_giris(:_username,:_password)";
                cmd = new NpgsqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("_username", textBox1.Text);
                cmd.Parameters.AddWithValue("_password", textBox2.Text);

                int result = (int)cmd.ExecuteScalar();

                conn.Close();

                if (result == 1)
                {
                    this.Hide();
                    new Form2(textBox1.Text).Show();
                }
                else
                {
                    MessageBox.Show("please check");
                    return;
                }

            }
            catch (Exception ex)
            {

                MessageBox.Show("Error:" + ex.Message, "Something went wrong", MessageBoxButtons.OK, MessageBoxIcon.Error);
                conn.Close();
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            this.Hide();
            Form4 f4 = new Form4();
            f4.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Hide();
            new Form2(textBox1.Text).Show();
        }
    }
}
