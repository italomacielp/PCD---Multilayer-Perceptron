# Defines
CC         = gcc
OBJ_DIR    = ./obj
SRC_DIR    = ./src
INCL_DIR   = ./include
OBJECTS    = $(addprefix $(OBJ_DIR)/, read_csv.o write_csv.o forward_propagation.o back_propagation.o mlp_trainer.o mlp_classifier.o)
INCLUDES   = $(addprefix $(INCL_DIR)/, read_csv.h write_csv.h forward_propagation.h back_propagation.h mlp_trainer.h mlp_classifier.h parameters.h)
CFLAGS     = -g -Wall -fopenmp -pg $(PARALLEL_FLAG)
VFLAGS     = -g -Wall -O3 -fopt-info-vec -fopt-info-vec-missed -ftree-vectorize
EXECUTABLE = MLP
LDFLAGS = -pg
FILES = vetorizacao_report.txt profile_report.txt

# Condição para ativar ENABLE_PARALLEL
ifeq ($(PARALLEL), 1)
PARALLEL_FLAG = -DENABLE_PARALLEL
else
PARALLEL_FLAG =
endif

# Generate the executable file
$(EXECUTABLE): $(SRC_DIR)/main.c $(OBJECTS)
	$(CC) $(CFLAGS) $< $(OBJECTS) -o $(EXECUTABLE) -I $(INCL_DIR) -L/pascal-releases-master/lib -lmpascalops -lm 

# Compile and Assemble C source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(INCLUDES)
	$(CC) $(CFLAGS) -I $(INCL_DIR) -c $< -o $@

# Clean the generated executable file and object files
clean:
	rm -f $(OBJECTS)
	rm -rf $(EXECUTABLE)* $(FILES)*

# Run the program and generate the profile report
profile_1: $(EXECUTABLE)
	./$(EXECUTABLE) 1 1 softmax,relu,tanh 1 sigmoid 0.01 10000 data/data_train.csv 1096 5 data/data_test.csv 275 5
	gprof $(EXECUTABLE) gmon.out -Qdotp100 -Qdotp120 | gprof2dot > dotp_gprof_1.dot

profile_2: $(EXECUTABLE)
	./$(EXECUTABLE) 1 2 softmax,relu,tanh 1 sigmoid 0.01 10000 data/data_train.csv 1096 5 data/data_test.csv 275 5
	gprof $(EXECUTABLE) gmon.out -Qdotp100 -Qdotp120 | gprof2dot > dotp_gprof_2.dot

profile_3: $(EXECUTABLE)
	./$(EXECUTABLE) 1 4 softmax,relu,tanh 1 sigmoid 0.01 10000 data/data_train.csv 1096 5 data/data_test.csv 275 5
	gprof $(EXECUTABLE) gmon.out -Qdotp100 -Qdotp120 | gprof2dot > dotp_gprof_3.dot

profile_4: $(EXECUTABLE)
	./$(EXECUTABLE) 1 8 softmax,relu,tanh 1 sigmoid 0.01 10000 data/data_train.csv 1096 5 data/data_test.csv 275 5
	gprof $(EXECUTABLE) gmon.out -Qdotp100 -Qdotp120 | gprof2dot > dotp_gprof_4.dot

profile_5: $(EXECUTABLE)
	./$(EXECUTABLE) 1 16 softmax,relu,tanh 1 sigmoid 0.01 10000 data/data_train.csv 1096 5 data/data_test.csv 275 5
	gprof $(EXECUTABLE) gmon.out -Qdotp100 -Qdotp120 | gprof2dot > dotp_gprof_5.dot

profile_6: $(EXECUTABLE)
	./$(EXECUTABLE) 1 32 softmax,relu,tanh 1 sigmoid 0.01 10000 data/data_train.csv 1096 5 data/data_test.csv 275 5
	gprof $(EXECUTABLE) gmon.out -Qdotp100 -Qdotp120 | gprof2dot > dotp_gprof_6.dot

# Run the program and generate vectorization
vectorization: $(SRC_DIR)/main.c $(OBJECTS)
	$(CC) $(VFLAGS) $< $(OBJECTS) -o $(EXECUTABLE) -I $(INCL_DIR) -lm gmon.out > vectorization.txt
