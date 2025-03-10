# These have the same names and meanings as in makenrs
NEKRS_CFLAGS :=
NEKRS_CXXFLAGS :=
NEKRS_FFLAGS :=
NEKRS_NEK5000_PPLIST := PARRSB DPROCMAP
NEKRS_LIBP_DEFINES := -DUSE_NULL_PROJECTION=1
USE_OCCA_MEM_BYTE_ALIGN := 64
OCCA_CXXFLAGS := -O2 -ftree-vectorize -funroll-loops -march=native -mtune=native

$(NEKRS_BUILDDIR)/Makefile: $(NEKRS_DIR)/CMakeLists.txt
	mkdir -p $(NEKRS_BUILDDIR)
	cd $(NEKRS_BUILDDIR) && \
	cmake -L -Wno-dev -Wfatal-errors \
	-DCMAKE_BUILD_TYPE="$(BUILD_TYPE)" \
	-DCMAKE_C_COMPILER="$(LIBMESH_CC_LIST)" \
	-DCMAKE_CXX_COMPILER="$(LIBMESH_CXX_LIST)" \
	-DCMAKE_Fortran_COMPILER="$(LIBMESH_F90_LIST)" \
	-DCMAKE_C_FLAGS="$(NEKRS_CFLAGS)" \
	-DCMAKE_CXX_FLAGS="$(NEKRS_CXXFLAGS)" \
	-DCMAKE_Fortran_FLAGS="$(NEKRS_FFLAGS)" \
	-DCMAKE_INSTALL_PREFIX="$(NEKRS_INSTALL_DIR)" \
	-DNEK5000_PPLIST="$(NEKRS_NEK5000_PPLIST)" \
	-DLIBP_DEFINES="$(NEKRS_LIBP_DEFINES)" \
	-DUSE_OCCA_MEM_BYTE_ALIGN="$(USE_OCCA_MEM_BYTE_ALIGN)" \
	-DOCCA_CXX="$(libmesh_CC)" \
	-DOCCA_CXXFLAGS="$(OCCA_CXXFLAGS)" \
	-DENABLE_CUDA="$(OCCA_CUDA_ENABLED)" \
	-DENABLE_OPENCL="$(OCCA_OPENCL_ENABLED)" \
	-DENABLE_HIP="$(OCCA_HIP_ENABLED)" \
	-DENABLE_AMGX="$(AMGX_ENABLED)" \
	$(NEKRS_DIR)

build_nekrs: | $(NEKRS_BUILDDIR)/Makefile
	make -C $(NEKRS_BUILDDIR) install

cleanall_nekrs: |  $(NEKRS_BUILDDIR)/Makefile
	make -C $(NEKRS_BUILDDIR) uninstall clean

clobber_nekrs:
	rm -rf $(NEKRS_LIB) $(NEKRS_BUILDDIR) $(NEKRS_INSTALL_DIR)

# cleanall and clobberall are from moose.mk
cleanall: cleanall_nekrs

clobberall: clobber_nekrs

.PHONY: build_nekrs cleanall_nekrs clobber_nekrs
