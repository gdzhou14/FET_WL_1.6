from PyQt5.QtWidgets import *
from PyQt5.QtGui import QFont
import sys
import serial
import serial.tools.list_ports
import time

class control_panel(QMainWindow):
    def __init__(self):
        super().__init__()
        self.Font = QFont('Roboto',16,QFont.Normal)
        self.lens1_status = False
        self.lens2_status = False
        self.lens3_status = False
        self.current_channel = 0
        self.initUI()
        self.connected = False
        self.power_status = True

    def initUI(self):
        self.bt0 = QPushButton('Make Zero',self)
        self.bt0.clicked.connect(self.make_zero)
        self.bt0.setStyleSheet('background-color: #FFFFFF')
        self.bt0.setFont(self.Font)

        self.bt2 = QPushButton('Channel 1',self)
        self.bt2.clicked.connect(self.change_to_CH1)
        self.bt2.setStyleSheet('background-color: #FFFFFF')
        self.bt2.setFont(self.Font)

        self.bt3 = QPushButton('Channel 2',self)
        self.bt3.clicked.connect(self.change_to_CH2)
        self.bt3.setStyleSheet('background-color: #FFFFFF')
        self.bt3.setFont(self.Font)

        self.bt4 = QPushButton('Channel 3',self)
        self.bt4.clicked.connect(self.change_to_CH3)
        self.bt4.setStyleSheet('background-color: #FFFFFF')
        self.bt4.setFont(self.Font)

        self.bt5 = QPushButton('Channel 4',self)
        self.bt5.clicked.connect(self.change_to_CH4)
        self.bt5.setStyleSheet('background-color: #FFFFFF')
        self.bt5.setFont(self.Font)
        
        self.bt6 = QPushButton('Lens 1',self)
        self.bt6.clicked.connect(self.Lens1_event)
        self.bt6.setStyleSheet('background-color: #FFFFFF')
        self.bt6.setFont(self.Font)

        self.bt7 = QPushButton('Lens 2',self)
        self.bt7.clicked.connect(self.Lens2_event)
        self.bt7.setStyleSheet('background-color: #FFFFFF')
        self.bt7.setFont(self.Font)

        self.bt8 = QPushButton('Lens 3',self)
        self.bt8.clicked.connect(self.Lens3_event)
        self.bt8.setStyleSheet('background-color: #FFFFFF')
        self.bt8.setFont(self.Font)

        self.bt9 = QPushButton('Connect',self)
        self.bt9.clicked.connect(self.device_connect)
        self.bt9.setStyleSheet('background-color: #FFFFFF')
        self.bt9.setFont(self.Font)

        self.bt10 = QPushButton('Load Chip',self)
        self.bt10.clicked.connect(self.loadchip_event)
        self.bt10.setStyleSheet('background-color: #FFFFFF')
        self.bt10.setFont(self.Font)

        self.bt_offset1 = QPushButton('+0.1',self)
        self.bt_offset1.clicked.connect(self.offset_p)
        self.bt_offset1.setStyleSheet('background-color: #FFFFFF')
        self.bt_offset1.setFont(self.Font)

        self.bt_offset2 = QPushButton('-0.1',self)
        self.bt_offset2.clicked.connect(self.offset_n)
        self.bt_offset2.setStyleSheet('background-color: #FFFFFF')
        self.bt_offset2.setFont(self.Font)

        self.bt_power = QPushButton('power',self)
        self.bt_power.clicked.connect(self.power_on_off)
        self.bt_power.setStyleSheet('background-color: #FFFFFF')
        self.bt_power.setFont(self.Font)

        vbox1 = QVBoxLayout()
        vbox1.addWidget(self.bt2)
        vbox1.addWidget(self.bt3)
        vbox1.addWidget(self.bt4)
        vbox1.addWidget(self.bt5)
        vbox1.addWidget(self.bt10)

        vbox2 = QVBoxLayout()
        vbox2.addWidget(self.bt9)
        vbox2.addWidget(self.bt_power)
        vbox2.addWidget(self.bt0)
        vbox2.addWidget(self.bt6)
        vbox2.addWidget(self.bt7)
        vbox2.addWidget(self.bt8)

        hbox1 = QHBoxLayout()
        hbox1.addLayout(vbox1)
        hbox1.addLayout(vbox2)

        hbox2 = QHBoxLayout()
        hbox2.addWidget(self.bt_offset1)
        hbox2.addWidget(self.bt_offset2)

        vbox3 = QVBoxLayout()
        vbox3.addLayout(hbox1)
        vbox3.addLayout(hbox2)
        

        frame = QWidget()
        frame.setLayout(vbox3)

        self.setCentralWidget(frame)
        self.setGeometry(300,300,400,300)

        self.statusBar()

        self.setWindowTitle('Control Panel')
        self.setStyleSheet('background-color: #CCCCCC')
        self.show()
    
    def power_on_off(self):
        if self.connected:
            if self.power_status:
                self.COM_Port.write(b'\x06\x02')
                self.power_status = bool(int(self.COM_Port.read(1)[0]))
            else:
                self.COM_Port.write(b'\x06\x01')
                self.power_status = bool(int(self.COM_Port.read(1)[0]))
            if self.power_status:
                self.bt_power.setStyleSheet('background-color: #4CAF50')
            else:
                self.bt_power.setStyleSheet('background-color: #b71c1c')
        else:
            self.statusBar().showMessage('Device not connected')

    def offset_n(self):
        if self.connected and self.power_status:
            self.statusBar().showMessage('-0.1mm offset')
            self.COM_send(b'\x05\x01')

    def offset_p(self):
        if self.connected and self.power_status:
            self.statusBar().showMessage('+0.1mm offset')
            self.COM_send(b'\x05\x02')
    
    def loadchip_event(self):
        if self.connected and self.power_status:
            self.statusBar().showMessage('load chip')
            self.current_channel = 0
            self.bt2.setStyleSheet('background-color: #FFFFFF')
            self.bt3.setStyleSheet('background-color: #FFFFFF')
            self.bt4.setStyleSheet('background-color: #FFFFFF')
            self.bt5.setStyleSheet('background-color: #FFFFFF')
            self.bt10.setStyleSheet('background-color: #4CAF50')
            self.COM_send(b'\x01\x05')
            self.COM_send(b'\x04\x05')
        else:
            self.statusBar().showMessage('device not connected')
        
    def device_connect(self):
        if not self.connected:
            ports = serial.tools.list_ports.comports()
            tempstr = ''
            for port in ports:
                if str(port).find('STMicroelectronics Virtual COM Port') != -1:
                    tempstr = str(port.device)
            if tempstr != '':
                self.COM_Port = serial.Serial(tempstr,115200)
                self.connected = True
                self.statusBar().showMessage('Device connected')
                self.bt9.setStyleSheet('background-color: #4CAF50')
                time.sleep(0.1)
                self.COM_Port.write(b'\x06\x01')
                self.power_status = bool(int(self.COM_Port.read(1)[0]))
                if self.power_status:
                    self.bt_power.setStyleSheet('background-color: #4CAF50')
                else:
                    self.bt_power.setStyleSheet('background-color: #b71c1c')
            else:
                self.statusBar().showMessage('Device not found')


    def COM_send(self,command):
        if self.connected and self.power_status:
            self.COM_Port.write(command)
            self.COM_Port.flush()
            time.sleep(0.01)                    
        elif not self.connected:
            self.statusBar().showMessage('Device not connected')
        elif not self.power_status:
            self.statusBar().showMessage('Power is off')
        else:
            pass


    def change_to_CH1(self):
        if self.connected and self.power_status:
            self.statusBar().showMessage('change to channel 1')
            if self.current_channel == 1:
                self.current_channel = 0
                self.bt2.setStyleSheet('background-color: #FFFFFF')
                self.COM_send(b'\x04\x05')
            else:
                self.current_channel = 1
                self.bt2.setStyleSheet('background-color: #4CAF50')
                self.bt3.setStyleSheet('background-color: #FFFFFF')
                self.bt4.setStyleSheet('background-color: #FFFFFF')
                self.bt5.setStyleSheet('background-color: #FFFFFF')
                self.bt10.setStyleSheet('background-color: #FFFFFF')
                self.COM_send(b'\x01\x01')
                self.COM_send(b'\x04\x01')
        else:
            self.statusBar().showMessage('device not connected')
            
    def change_to_CH2(self):
        if self.connected and self.power_status:
            self.statusBar().showMessage('change to channel 2')
            if self.current_channel == 2:
                self.current_channel = 0
                self.bt3.setStyleSheet('background-color: #FFFFFF')
                self.COM_send(b'\x04\x05')
            else:
                self.current_channel = 2
                self.bt2.setStyleSheet('background-color: #FFFFFF')
                self.bt3.setStyleSheet('background-color: #4CAF50')
                self.bt4.setStyleSheet('background-color: #FFFFFF')
                self.bt5.setStyleSheet('background-color: #FFFFFF')
                self.bt10.setStyleSheet('background-color: #FFFFFF')
                self.COM_send(b'\x01\x02')
                self.COM_send(b'\x04\x02')
        else:
            self.statusBar().showMessage('device not connected')

    def change_to_CH3(self):
        if self.connected and self.power_status:
            self.statusBar().showMessage('change to channel 3')
            if self.current_channel == 3:
                self.current_channel = 0
                self.bt4.setStyleSheet('background-color: #FFFFFF')
                self.COM_send(b'\x04\x05')
            else:
                self.current_channel = 3
                self.bt2.setStyleSheet('background-color: #FFFFFF')
                self.bt3.setStyleSheet('background-color: #FFFFFF')
                self.bt4.setStyleSheet('background-color: #4CAF50')
                self.bt5.setStyleSheet('background-color: #FFFFFF')
                self.bt10.setStyleSheet('background-color: #FFFFFF')
                self.COM_send(b'\x01\x03')
                self.COM_send(b'\x04\x03')
        else:
            self.statusBar().showMessage('device not connected')

    def change_to_CH4(self):
        if self.connected and self.power_status:
            self.statusBar().showMessage('change to channel 4')
            if self.current_channel == 4:
                self.current_channel = 0
                self.bt5.setStyleSheet('background-color: #FFFFFF')
                self.COM_send(b'\x04\x05')
            else:
                self.current_channel = 4
                self.bt2.setStyleSheet('background-color: #FFFFFF')
                self.bt3.setStyleSheet('background-color: #FFFFFF')
                self.bt4.setStyleSheet('background-color: #FFFFFF')
                self.bt5.setStyleSheet('background-color: #4CAF50')
                self.bt10.setStyleSheet('background-color: #FFFFFF')
                self.COM_send(b'\x01\x04')
                self.COM_send(b'\x04\x04')
        else:
            self.statusBar().showMessage('device not connected')

    def make_zero(self):
        if self.connected and self.power_status:
            self.statusBar().showMessage('make zero')
            self.current_channel = 0
            self.bt2.setStyleSheet('background-color: #FFFFFF')
            self.bt3.setStyleSheet('background-color: #FFFFFF')
            self.bt4.setStyleSheet('background-color: #FFFFFF')
            self.bt5.setStyleSheet('background-color: #FFFFFF')
            self.bt10.setStyleSheet('background-color: #FFFFFF')
            self.COM_send(b'\x03')
        else:
            self.statusBar().showMessage('device not connected')

    def Lens1_event(self):
        if self.connected and self.power_status:
            self.statusBar().showMessage('lens 1 event')
            if self.lens1_status:
                self.lens1_status = False
                self.bt6.setStyleSheet('background-color: #FFFFFF')
            else:
                self.lens1_status = True
                self.bt6.setStyleSheet('background-color: #4CAF50')
            self.Lens_control()
        else:
            self.statusBar().showMessage('device not connected')

    def Lens2_event(self):
        if self.connected and self.power_status:
            self.statusBar().showMessage('lens 2 event')
            if self.lens2_status:
                self.lens2_status = False
                self.bt7.setStyleSheet('background-color: #FFFFFF')
            else:
                self.lens2_status = True
                self.bt7.setStyleSheet('background-color: #4CAF50')
            self.Lens_control()
        else:
            self.statusBar().showMessage('device not connected')

    def Lens3_event(self):
        if self.connected and self.power_status:
            self.statusBar().showMessage('lens 3 event')
            if self.lens3_status:
                self.lens3_status = False
                self.bt8.setStyleSheet('background-color: #FFFFFF')
            else:
                self.lens3_status = True
                self.bt8.setStyleSheet('background-color: #4CAF50')
            self.Lens_control()
        else:
            self.statusBar().showMessage('device not connected')
    
    def Lens_control(self):
        command = 0
        if self.lens1_status:
            command += 1
        if self.lens2_status:
            command += 2
        if self.lens3_status:
            command += 4
        self.COM_send(b'\x02'+bytes([command]))

if __name__ == '__main__':
    app = QApplication(sys.argv)
    cp = control_panel()
    sys.exit(app.exec_())
