namespace SmartTraveller
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.pnlLogin = new System.Windows.Forms.Panel();
            this.lblAuthenticate = new System.Windows.Forms.Label();
            this.txtLogin = new System.Windows.Forms.TextBox();
            this.pnlIdentifyPassenger = new System.Windows.Forms.Panel();
            this.txtPassengerId = new System.Windows.Forms.TextBox();
            this.pnlSuccess = new System.Windows.Forms.Panel();
            this.pnlNotValid = new System.Windows.Forms.Panel();
            this.pnlNoCredit = new System.Windows.Forms.Panel();
            this.pnlThank = new System.Windows.Forms.Panel();
            this.pnlAlert = new System.Windows.Forms.Panel();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.pictureBox3 = new System.Windows.Forms.PictureBox();
            this.pictureBox4 = new System.Windows.Forms.PictureBox();
            this.pictureBox5 = new System.Windows.Forms.PictureBox();
            this.pictureBox6 = new System.Windows.Forms.PictureBox();
            this.pictureBox7 = new System.Windows.Forms.PictureBox();
            this.pnlLogin.SuspendLayout();
            this.pnlIdentifyPassenger.SuspendLayout();
            this.pnlSuccess.SuspendLayout();
            this.pnlNotValid.SuspendLayout();
            this.pnlNoCredit.SuspendLayout();
            this.pnlThank.SuspendLayout();
            this.pnlAlert.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox3)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox4)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox5)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox6)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox7)).BeginInit();
            this.SuspendLayout();
            // 
            // pnlLogin
            // 
            this.pnlLogin.BackColor = System.Drawing.Color.Transparent;
            this.pnlLogin.Controls.Add(this.lblAuthenticate);
            this.pnlLogin.Controls.Add(this.pictureBox1);
            this.pnlLogin.Controls.Add(this.txtLogin);
            this.pnlLogin.Location = new System.Drawing.Point(0, 0);
            this.pnlLogin.Name = "pnlLogin";
            this.pnlLogin.Size = new System.Drawing.Size(1280, 720);
            this.pnlLogin.TabIndex = 0;
            // 
            // lblAuthenticate
            // 
            this.lblAuthenticate.AutoSize = true;
            this.lblAuthenticate.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(70)))), ((int)(((byte)(103)))), ((int)(((byte)(133)))));
            this.lblAuthenticate.Font = new System.Drawing.Font("Microsoft Sans Serif", 26.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblAuthenticate.ForeColor = System.Drawing.Color.White;
            this.lblAuthenticate.Location = new System.Drawing.Point(998, 625);
            this.lblAuthenticate.Name = "lblAuthenticate";
            this.lblAuthenticate.Size = new System.Drawing.Size(210, 39);
            this.lblAuthenticate.TabIndex = 3;
            this.lblAuthenticate.Text = "Authenticate";
            this.lblAuthenticate.Click += new System.EventHandler(this.lblAuthenticate_Click);
            // 
            // txtLogin
            // 
            this.txtLogin.Location = new System.Drawing.Point(42, 49);
            this.txtLogin.Name = "txtLogin";
            this.txtLogin.Size = new System.Drawing.Size(238, 20);
            this.txtLogin.TabIndex = 1;
            this.txtLogin.TextChanged += new System.EventHandler(this.txtLogin_TextChanged);
            // 
            // pnlIdentifyPassenger
            // 
            this.pnlIdentifyPassenger.Controls.Add(this.pictureBox2);
            this.pnlIdentifyPassenger.Controls.Add(this.txtPassengerId);
            this.pnlIdentifyPassenger.Location = new System.Drawing.Point(0, 0);
            this.pnlIdentifyPassenger.Name = "pnlIdentifyPassenger";
            this.pnlIdentifyPassenger.Size = new System.Drawing.Size(1280, 720);
            this.pnlIdentifyPassenger.TabIndex = 1;
            // 
            // txtPassengerId
            // 
            this.txtPassengerId.Location = new System.Drawing.Point(12, 99);
            this.txtPassengerId.Name = "txtPassengerId";
            this.txtPassengerId.Size = new System.Drawing.Size(164, 20);
            this.txtPassengerId.TabIndex = 1;
            this.txtPassengerId.TextChanged += new System.EventHandler(this.txtPassengerId_TextChanged);
            // 
            // pnlSuccess
            // 
            this.pnlSuccess.Controls.Add(this.pictureBox3);
            this.pnlSuccess.Location = new System.Drawing.Point(0, 0);
            this.pnlSuccess.Name = "pnlSuccess";
            this.pnlSuccess.Size = new System.Drawing.Size(1280, 720);
            this.pnlSuccess.TabIndex = 2;
            // 
            // pnlNotValid
            // 
            this.pnlNotValid.Controls.Add(this.pictureBox6);
            this.pnlNotValid.Location = new System.Drawing.Point(0, 0);
            this.pnlNotValid.Name = "pnlNotValid";
            this.pnlNotValid.Size = new System.Drawing.Size(1280, 720);
            this.pnlNotValid.TabIndex = 3;
            // 
            // pnlNoCredit
            // 
            this.pnlNoCredit.Controls.Add(this.pictureBox4);
            this.pnlNoCredit.Location = new System.Drawing.Point(0, 0);
            this.pnlNoCredit.Name = "pnlNoCredit";
            this.pnlNoCredit.Size = new System.Drawing.Size(1280, 720);
            this.pnlNoCredit.TabIndex = 3;
            // 
            // pnlThank
            // 
            this.pnlThank.Controls.Add(this.pictureBox7);
            this.pnlThank.Location = new System.Drawing.Point(0, 0);
            this.pnlThank.Name = "pnlThank";
            this.pnlThank.Size = new System.Drawing.Size(1280, 720);
            this.pnlThank.TabIndex = 4;
            // 
            // pnlAlert
            // 
            this.pnlAlert.Controls.Add(this.pictureBox5);
            this.pnlAlert.Location = new System.Drawing.Point(0, 0);
            this.pnlAlert.Name = "pnlAlert";
            this.pnlAlert.Size = new System.Drawing.Size(1280, 720);
            this.pnlAlert.TabIndex = 5;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox1.Image")));
            this.pictureBox1.Location = new System.Drawing.Point(0, 0);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(1280, 720);
            this.pictureBox1.TabIndex = 6;
            this.pictureBox1.TabStop = false;
            // 
            // pictureBox2
            // 
            this.pictureBox2.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox2.Image")));
            this.pictureBox2.Location = new System.Drawing.Point(0, 0);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(1280, 720);
            this.pictureBox2.TabIndex = 2;
            this.pictureBox2.TabStop = false;
            // 
            // pictureBox3
            // 
            this.pictureBox3.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox3.Image")));
            this.pictureBox3.Location = new System.Drawing.Point(0, 0);
            this.pictureBox3.Name = "pictureBox3";
            this.pictureBox3.Size = new System.Drawing.Size(1280, 720);
            this.pictureBox3.TabIndex = 0;
            this.pictureBox3.TabStop = false;
            // 
            // pictureBox4
            // 
            this.pictureBox4.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox4.Image")));
            this.pictureBox4.Location = new System.Drawing.Point(0, 0);
            this.pictureBox4.Name = "pictureBox4";
            this.pictureBox4.Size = new System.Drawing.Size(1280, 720);
            this.pictureBox4.TabIndex = 0;
            this.pictureBox4.TabStop = false;
            // 
            // pictureBox5
            // 
            this.pictureBox5.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox5.Image")));
            this.pictureBox5.Location = new System.Drawing.Point(0, 0);
            this.pictureBox5.Name = "pictureBox5";
            this.pictureBox5.Size = new System.Drawing.Size(1280, 720);
            this.pictureBox5.TabIndex = 0;
            this.pictureBox5.TabStop = false;
            // 
            // pictureBox6
            // 
            this.pictureBox6.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox6.Image")));
            this.pictureBox6.Location = new System.Drawing.Point(0, 0);
            this.pictureBox6.Name = "pictureBox6";
            this.pictureBox6.Size = new System.Drawing.Size(1280, 720);
            this.pictureBox6.TabIndex = 0;
            this.pictureBox6.TabStop = false;
            // 
            // pictureBox7
            // 
            this.pictureBox7.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox7.Image")));
            this.pictureBox7.Location = new System.Drawing.Point(0, 0);
            this.pictureBox7.Name = "pictureBox7";
            this.pictureBox7.Size = new System.Drawing.Size(1280, 720);
            this.pictureBox7.TabIndex = 0;
            this.pictureBox7.TabStop = false;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1281, 721);
            this.ControlBox = false;
            this.Controls.Add(this.pnlNotValid);
            this.Controls.Add(this.pnlThank);
            this.Controls.Add(this.pnlIdentifyPassenger);
            this.Controls.Add(this.pnlNoCredit);
            this.Controls.Add(this.pnlSuccess);
            this.Controls.Add(this.pnlLogin);
            this.Controls.Add(this.pnlAlert);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.pnlLogin.ResumeLayout(false);
            this.pnlLogin.PerformLayout();
            this.pnlIdentifyPassenger.ResumeLayout(false);
            this.pnlIdentifyPassenger.PerformLayout();
            this.pnlSuccess.ResumeLayout(false);
            this.pnlNotValid.ResumeLayout(false);
            this.pnlNoCredit.ResumeLayout(false);
            this.pnlThank.ResumeLayout(false);
            this.pnlAlert.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox3)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox4)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox5)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox6)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox7)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        
        private System.Windows.Forms.Panel pnlLogin;
        public System.Windows.Forms.TextBox txtLogin;
        private System.Windows.Forms.Panel pnlIdentifyPassenger;
        public System.Windows.Forms.TextBox txtPassengerId;
        private System.Windows.Forms.Panel pnlSuccess;
        private System.Windows.Forms.Panel pnlNotValid;
        private System.Windows.Forms.Panel pnlNoCredit;
        private System.Windows.Forms.Panel pnlThank;
        private System.Windows.Forms.Label lblAuthenticate;
        private System.Windows.Forms.Panel pnlAlert;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.PictureBox pictureBox2;
        private System.Windows.Forms.PictureBox pictureBox3;
        private System.Windows.Forms.PictureBox pictureBox4;
        private System.Windows.Forms.PictureBox pictureBox5;
        private System.Windows.Forms.PictureBox pictureBox6;
        private System.Windows.Forms.PictureBox pictureBox7;
    }
}

