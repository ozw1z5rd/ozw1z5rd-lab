<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="xbr" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1" />
        <signal name="XLXN_2" />
        <signal name="XLXN_3" />
        <signal name="XLXN_4" />
        <port polarity="Input" name="XLXN_1" />
        <port polarity="Input" name="XLXN_2" />
        <port polarity="Input" name="XLXN_3" />
        <port polarity="Output" name="XLXN_4" />
        <blockdef name="and3">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="192" y1="-128" y2="-128" x1="256" />
            <line x2="144" y1="-176" y2="-176" x1="64" />
            <line x2="64" y1="-80" y2="-80" x1="144" />
            <arc ex="144" ey="-176" sx="144" sy="-80" r="48" cx="144" cy="-128" />
            <line x2="64" y1="-64" y2="-192" x1="64" />
        </blockdef>
        <block symbolname="and3" name="XLXI_1">
            <blockpin signalname="XLXN_3" name="I0" />
            <blockpin signalname="XLXN_2" name="I1" />
            <blockpin signalname="XLXN_1" name="I2" />
            <blockpin signalname="XLXN_4" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1376" y="1296" name="XLXI_1" orien="R0" />
        <branch name="XLXN_1">
            <wire x2="1376" y1="1104" y2="1104" x1="1344" />
        </branch>
        <iomarker fontsize="28" x="1344" y="1104" name="XLXN_1" orien="R180" />
        <branch name="XLXN_2">
            <wire x2="1376" y1="1168" y2="1168" x1="1344" />
        </branch>
        <iomarker fontsize="28" x="1344" y="1168" name="XLXN_2" orien="R180" />
        <branch name="XLXN_3">
            <wire x2="1376" y1="1232" y2="1232" x1="1344" />
        </branch>
        <iomarker fontsize="28" x="1344" y="1232" name="XLXN_3" orien="R180" />
        <branch name="XLXN_4">
            <wire x2="1664" y1="1168" y2="1168" x1="1632" />
        </branch>
        <iomarker fontsize="28" x="1664" y="1168" name="XLXN_4" orien="R0" />
    </sheet>
</drawing>