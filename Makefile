NAME = IndexHTMLMakefile
RM_RF = rm -rf
REAL_TARGET = $(PROJECT_NAME)

all :: $(NAME) $(REAL_TARGET)

clean :: clean_libs

clean_libs: $(NAME)
	make -f $(NAME) clean
	$(RM_RF) $(NAME)

$(NAME): index.html genmakefile.pl
	perl -f genmakefile.pl index.html "$(REAL_TARGET)" >$(NAME)

$(REAL_TARGET): $(NAME)
	make -f $(NAME)