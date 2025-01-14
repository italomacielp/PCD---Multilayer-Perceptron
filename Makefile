# Defines
CC         = gcc
OBJ_DIR    = ./obj
SRC_DIR    = ./src
INCL_DIR   = ./include
OBJECTS    = $(addprefix $(OBJ_DIR)/, read_csv.o write_csv.o forward_propagation.o back_propagation.o mlp_trainer.o mlp_classifier.o)
INCLUDES   = $(addprefix $(INCL_DIR)/, read_csv.h write_csv.h forward_propagation.h back_propagation.h mlp_trainer.h mlp_classifier.h parameters.h)
CFLAGS     = -g -Wall -fopenmp -pg
VFLAGS     = -g -Wall -O3 -fopt-info-vec -fopt-info-vec-missed -ftree-vectorize
EXECUTABLE = MLP
LDFLAGS = -pg
FILES = vetorizacao_report.txt profile_report.txt

# Generate the executable file
$(EXECUTABLE): $(SRC_DIR)/main.c $(OBJECTS)
	$(CC) $(CFLAGS) $< $(OBJECTS) -L/pascal-releases-master/lib -o $(EXECUTABLE) -I $(INCL_DIR) -lm -lmpascalops

# Compile and Assemble C source files into object files
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(INCLUDES)
	$(CC) $(CFLAGS) -I $(INCL_DIR) -c $< -o $@

# Clean the generated executable file and object files
clean:
	rm -f $(OBJECTS)
	rm -rf $(EXECUTABLE)* $(FILES)*

# Run the program and generate the profile report
profile: $(EXECUTABLE)
	./$(EXECUTABLE) 1 4 softmax,relu,tanh 1 sigmoid 0.01 10000 data/data_train.csv 1096 5 data/data_test.csv 275 5
	gprof $(EXECUTABLE) gmon.out -Qdotp100 -Qdotp120 | gprof2dot > dotp_gprof.dot

# Run the program and generate vectorization
vectorization: $(SRC_DIR)/main.c $(OBJECTS)
	$(CC) $(VFLAGS) $< $(OBJECTS) -o $(EXECUTABLE) -I $(INCL_DIR) -lm gmon.out > vectorization.txt

