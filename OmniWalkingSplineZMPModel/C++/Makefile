CXX				= g++
CXXFLAGS		+=-O3 -g -ansi -Wall -ansi -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -DGLNX86 -DGCC  -DMX_COMPAT_32 -O -DNDEBUG
#LDFLAGS			+= -Wl,-R-leng -lmx -lm 

ROOT_DIR			= .

ROOT_WALKSKILL			=walkSkill

ROOT_COMGENERATOR		= $(ROOT_WALKSKILL)/comGenerator

ROOT_ZMPGENERATOR		= $(ROOT_WALKSKILL)/ZMPgenerator

ROOT_WALKSTEPPLANNER		= $(ROOT_WALKSKILL)/walkStepPlanner

ROOT_TOOLS			=tools

ROOT_INCLUDE			= -I$(ROOT_DIR) 

WALKSKILL_INCLUDE		= -I$(ROOT_WALKSKILL)

COMGENERATOR_INCLUDE		= -I$(ROOT_COMGENERATOR) 

ZMPGENERATOR_INCLUDE		= -I$(ROOT_ZMPGENERATOR) 

WALKSTEPPLANNER_INCLUDE		= -I$(ROOT_WALKSTEPPLANNER)

TOOLS_INCLUDE			= -I$(ROOT_TOOLS) 

INCLUDEPATH			=\
		$(ROOT_INCLUDE)\
		$(WALKSKILL_INCLUDE)\
		$(COMGENERATOR_INCLUDE)\
		$(ZMPGENERATOR_INCLUDE)\
		$(WALKSTEPPLANNER_INCLUDE)\
		$(TOOLS_INCLUDE)\

P			= \33[1;34m Building \33[1;31m $@ \33[1;34m\33[0m
ACK			= \33[1;32m\t\t[OK]\33[0m

ROOT_OBJECTS	= \
		$(ROOT_TOOLS)/Geometry.o\
		$(ROOT_TOOLS)/Vector3f.o\
		$(ROOT_WALKSTEPPLANNER)/walkStep.o \
		$(ROOT_WALKSKILL)/omniWalkExecuter.o\
		$(ROOT_WALKSTEPPLANNER)/stepGenerator.o\
		$(ROOT_DIR)/main.o \
		$(ROOT_ZMPGENERATOR)/zmpGenerator.o\
		$(ROOT_COMGENERATOR)/comGenerator.o 
				
OBJECTS	= \
		 $(ROOT_OBJECTS) \
 		
NOBJECTS	= \
		

%.o: %.cpp %.h
	@echo -e "$(P)"
	$(CXX) $(CXXFLAGS) $(INCLUDEPATH) -c $< -o $@
	@echo -e "$(ACK)"

%.o: %.cpp 
	@echo -e "$(P)"
	$(CXX) $(CXXFLAGS) $(INCLUDEPATH) -c $< -o $@
	@echo -e "$(ACK)"

walkagent: ${OBJECTS} 
	$(CXX) $(CXXFLAGS) $(LIBRARY_PATH) $(INCLUDEPATH) -o $@ $(OBJECTS) #$(LDFLAGS)

SRCS = \
	   $(OBJECTS:%.o=%.cpp)

clean:
	rm  -f *.o core* *~ walkagent $(OBJECTS) $(NOBJECTS) 
	echo -e "\33[1;35m\n Cleanning Files...\33[0m\n"


# DO NOT DELETE
