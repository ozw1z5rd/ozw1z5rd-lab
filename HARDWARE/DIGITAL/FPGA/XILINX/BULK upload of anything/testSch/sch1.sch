<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="xbr" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_3" />
        <signal name="XLXN_4" />
        <signal name="XLXN_5" />
        <signal name="XLXN_6" />
        <port polarity="Input" name="XLXN_3" />
        <port polarity="Input" name="XLXN_4" />
        <port polarity="Input" name="XLXN_5" />
        <port polarity="Output" name="XLXN_6" />
        <blockdef name="and3b1">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="40" y1="-64" y2="-64" x1="0" />
            <circle r="12" cx="52" cy="-64" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="192" y1="-128" y2="-128" x1="256" />
            <line x2="64" y1="-64" y2="-192" x1="64" />
            <arc ex="144" ey="-176" sx="144" sy="-80" r="48" cx="144" cy="-128" />
            <line x2="64" y1="-80" y2="-80" x1="144" />
            <line x2="144" y1="-176" y2="-176" x1="64" />
        </blockdef>
        <block symbolname="and3b1" name="XLXI_2">
            <blockpin signalname="XLXN_5" name="I0" />
            <blockpin signalname="XLXN_4" name="I1" />
            <blockpin signalname="XLXN_3" name="I2" />
            <blockpin signalname="XLXN_6" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="1072" y="672" name="XLXI_2" orien="R0">
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="VhdlModel" x="0" y="-12" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="Libver" x="0" y="52" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="Level" x="0" y="84" type="instance" />
            <attrtext style="fontsize:28;fontname:Arial;displayformat:NAMEEQUALSVALUE" attrname="Device" x="0" y="116" type="instance" />
        </instance>
        <branch name="XLXN_3">
            <wire x2="1072" y1="480" y2="480" x1="448" />
        </branch>
        <branch name="XLXN_4">
            <wire x2="1072" y1="544" y2="544" x1="448" />
        </branch>
        <iomarker fontsize="28" x="448" y="480" name="XLXN_3" orien="R180" />
        <iomarker fontsize="28" x="448" y="544" name="XLXN_4" orien="R180" />
        <branch name="XLXN_5">
            <wire x2="1072" y1="608" y2="608" x1="1040" />
        </branch>
        <iomarker fontsize="28" x="1040" y="608" name="XLXN_5" orien="R180" />
        <branch name="XLXN_6">
            <wire x2="1360" y1="544" y2="544" x1="1328" />
        </branch>
        <iomarker fontsize="28" x="1360" y="544" name="XLXN_6" orien="R0" />
    </sheet>
</drawing>