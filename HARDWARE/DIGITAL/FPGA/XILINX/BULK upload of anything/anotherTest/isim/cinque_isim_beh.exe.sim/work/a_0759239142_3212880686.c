/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x8ddf5b5d */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "/host/Garage/Garage/vhdl/anotherTest/cinque.vhd";
extern char *IEEE_P_2592010699;

unsigned char ieee_p_2592010699_sub_3488768496604610246_503743352(char *, unsigned char , unsigned char );
unsigned char ieee_p_2592010699_sub_3488768497506413324_503743352(char *, unsigned char , unsigned char );


static void work_a_0759239142_3212880686_p_0(char *t0)
{
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    unsigned char t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;

LAB0:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 1512U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 3464);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(53, ng0);
    t7 = (t0 + 1032U);
    t8 = *((char **)t7);
    t9 = *((unsigned char *)t8);
    t7 = (t0 + 1192U);
    t10 = *((char **)t7);
    t11 = *((unsigned char *)t10);
    t12 = ieee_p_2592010699_sub_3488768496604610246_503743352(IEEE_P_2592010699, t9, t11);
    t7 = (t0 + 3544);
    t13 = (t7 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    *((unsigned char *)t16) = t12;
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(54, ng0);
    t2 = (t0 + 1992U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t2 = (t0 + 3608);
    t7 = (t2 + 56U);
    t8 = *((char **)t7);
    t10 = (t8 + 56U);
    t13 = *((char **)t10);
    *((unsigned char *)t13) = t1;
    xsi_driver_first_trans_fast_port(t2);
    xsi_set_current_line(55, ng0);
    t2 = (t0 + 1992U);
    t3 = *((char **)t2);
    t1 = *((unsigned char *)t3);
    t2 = (t0 + 1352U);
    t7 = *((char **)t2);
    t4 = *((unsigned char *)t7);
    t5 = ieee_p_2592010699_sub_3488768497506413324_503743352(IEEE_P_2592010699, t1, t4);
    t2 = (t0 + 3672);
    t8 = (t2 + 56U);
    t10 = *((char **)t8);
    t13 = (t10 + 56U);
    t14 = *((char **)t13);
    *((unsigned char *)t14) = t5;
    xsi_driver_first_trans_fast_port(t2);
    goto LAB3;

LAB5:    t2 = (t0 + 1472U);
    t6 = xsi_signal_has_event(t2);
    t1 = t6;
    goto LAB7;

}


extern void work_a_0759239142_3212880686_init()
{
	static char *pe[] = {(void *)work_a_0759239142_3212880686_p_0};
	xsi_register_didat("work_a_0759239142_3212880686", "isim/cinque_isim_beh.exe.sim/work/a_0759239142_3212880686.didat");
	xsi_register_executes(pe);
}
