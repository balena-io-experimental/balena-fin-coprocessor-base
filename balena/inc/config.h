#ifndef __CONFIG_H_INCLUDED__
#define __CONFIG_H_INCLUDED__

#ifdef __cplusplus
extern "C" {
#endif

#define BSP_DCDC_INIT EMU_DCDCINIT_DEFAULT
#define BSP_CLK_HFXO_INIT CMU_HFXOINIT_DEFAULT
#define BSP_CLK_HFXO_FREQ (38400000UL)
#define BSP_CLK_LFXO_INIT CMU_LFXOINIT_DEFAULT
#define BSP_CLK_LFXO_CTUNE (32U)
#define BSP_CLK_LFXO_FREQ (32768U)

#ifdef __cplusplus
}
#endif

#endif
