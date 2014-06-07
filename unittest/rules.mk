CC := gcc
CXX := g++

CFLAGS := -g -D_GNUCC -fno-builtin $(CFLAGS) -m32
LDFLAGS := 

TARGET:= UnitTest
TARGET_BIN = $(TARGET)$(BIN_EXT) 
C_SRCS := $(filter %.c,$(SRCS))
CPP_SRCS := $(filter %.cpp,$(SRCS))

OBJS := $(notdir $(SRCS:.c=.o))
OBJS += $(notdir $(SRCS:.cpp=.o))
OBJS := $(filter %.o, $(OBJS))

$(TARGET_BIN): $(OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS) $(CFLAGS) 

$(foreach src,$(C_SRCS),$(eval $(notdir $(src:.c=.o)): $(src);$(CC) -o $$@ $(CFLAGS) -c $$<))

$(foreach src,$(CPP_SRCS),$(eval $(notdir $(src:.cpp=.o)): $(src); $(CXX) $(CFLAGS) -c $$<))

run: $(TARGET_BIN)
	$(abspath $<)
	
clean:
	-$(RM) $(TARGET_BIN) *.o *.cov


