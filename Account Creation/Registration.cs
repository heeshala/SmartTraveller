using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Google.Cloud.Firestore;
namespace AccountCreation
{
    public partial class Registration : Form
    {
        FirestoreDb database;
        public Registration()
        {
            InitializeComponent();
            pnlAgent.Hide();
            pnlPassenger.Hide();
            
            String path = AppDomain.CurrentDomain.BaseDirectory + @"smart-traveller.json";
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", path);
            database = FirestoreDb.Create("smart-traveller-302307");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            pnlAccntType.Hide();
            pnlPassenger.Show();

        }

        private void button2_Click(object sender, EventArgs e)
        {
            pnlAccntType.Hide();
            pnlAgent.Show();
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Data_Entry(txtNIC.Text);
        }

        void Data_Entry(string NIC)
        {
            try
            {


                DocumentReference docRef = database.Collection("passenger").Document(NIC);
                Dictionary<string, object> data1 = new Dictionary<string, object>
            {
                    { "credits", int.Parse(txtCred.Text) },
                    { "name", txtName.Text },
                    { "rfid", txtRID.Text},
                    { "slat" ,"6.714210" },
                    { "slon","80.059334" },
                    { "travelling","No" },
                    { "nfc","0x012e41312f8a4338" }

            };

                docRef.SetAsync(data1);
                MessageBox.Show("data added successfully");
                txtNIC.Clear();
                txtCred.Clear();
                txtName.Clear();
                
                txtRID.Clear();
            }
            catch (Exception)
            {
                MessageBox.Show("Unsuccessfull");
            }
        }

       

        public static string key = "b14ca5898a4e4133bbce2ea2315a1916";
        public static string EncryptString(string key, string plainText)
        {
            byte[] iv = new byte[16];
            byte[] array;

            using (Aes aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes(key);
                aes.IV = iv;

                ICryptoTransform encryptor = aes.CreateEncryptor(aes.Key, aes.IV);

                using (MemoryStream memoryStream = new MemoryStream())
                {
                    using (CryptoStream cryptoStream = new CryptoStream((Stream)memoryStream, encryptor, CryptoStreamMode.Write))
                    {
                        using (StreamWriter streamWriter = new StreamWriter((Stream)cryptoStream))
                        {
                            streamWriter.Write(plainText);
                        }

                        array = memoryStream.ToArray();
                    }
                }
            }

            return Convert.ToBase64String(array);
        }
    }


    
}
