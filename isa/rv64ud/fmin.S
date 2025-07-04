# See LICENSE for license details.

#*****************************************************************************
# fmin.S
#-----------------------------------------------------------------------------
#
# Test f{min|max}.d instructinos.
#

#include "riscv_test.h"
#include "test_macros.h"

RVTEST_RV64UF
RVTEST_CODE_BEGIN

#if __riscv_xlen == 32
    # Replace the function with the 32-bit variant defined in test_macros.h
    #undef TEST_FP_OP2_D
    #define TEST_FP_OP2_D TEST_FP_OP2_D32
    #undef TEST_FP_OP2_D_HEX
    #define TEST_FP_OP2_D_HEX TEST_FP_OP2_D32_HEX
#endif

  #-------------------------------------------------------------
  # Arithmetic tests
  #-------------------------------------------------------------

  TEST_FP_OP2_D( 2,  fmin.d, 0,        1.0,        2.5,        1.0 );
  TEST_FP_OP2_D( 3,  fmin.d, 0,    -1235.1,    -1235.1,        1.1 );
  TEST_FP_OP2_D( 4,  fmin.d, 0,    -1235.1,        1.1,    -1235.1 );
  TEST_FP_OP2_D( 5,  fmin.d, 0,    -1235.1,        NaN,    -1235.1 );
  TEST_FP_OP2_D( 6,  fmin.d, 0, 0.00000001, 3.14159265, 0.00000001 );
  TEST_FP_OP2_D( 7,  fmin.d, 0,       -2.0,       -1.0,       -2.0 );

  TEST_FP_OP2_D(12,  fmax.d, 0,        2.5,        2.5,        1.0 );
  TEST_FP_OP2_D(13,  fmax.d, 0,        1.1,    -1235.1,        1.1 );
  TEST_FP_OP2_D(14,  fmax.d, 0,        1.1,        1.1,    -1235.1 );
  TEST_FP_OP2_D(15,  fmax.d, 0,    -1235.1,        NaN,    -1235.1 );
  TEST_FP_OP2_D(16,  fmax.d, 0, 3.14159265, 3.14159265, 0.00000001 );
  TEST_FP_OP2_D(17,  fmax.d, 0,       -1.0,       -1.0,       -2.0 );

  # FMAX(sNaN, x) = x
  TEST_FP_OP2_D_HEX(20,  fmax.d, 0x10, 0x3ff0000000000000, sNaNd, 0x3ff0000000000000);
  # FMAX(qNaN, qNaN) = canonical NaN
  TEST_FP_OP2_D_HEX(21,  fmax.d, 0x00, qNaNd, 0x7fffffffffffffff, 0x7fffffffffffffff);

  # -0.0 < +0.0
  TEST_FP_OP2_D(30,  fmin.d, 0,       -0.0,       -0.0,        0.0 );
  TEST_FP_OP2_D(31,  fmin.d, 0,       -0.0,        0.0,       -0.0 );
  TEST_FP_OP2_D(32,  fmax.d, 0,        0.0,       -0.0,        0.0 );
  TEST_FP_OP2_D(33,  fmax.d, 0,        0.0,        0.0,       -0.0 );

  TEST_PASSFAIL

RVTEST_CODE_END

  .data
RVTEST_DATA_BEGIN

  TEST_DATA

RVTEST_DATA_END
