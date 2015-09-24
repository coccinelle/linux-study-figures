R_PDF=lifespan-min-max.pdf \
	lifespan-improvement-right.pdf \
	churn.pdf
GEN_JGR=
#	error-rate-by-churn.jgr    \
#	error-rate-by-X.jgr
DIR_IMG=notes-evol-kind        \
	error-rate-by-age      \
	error-rate-by-age-4-241-lin6b-all_fcts \
	error-rate-by-fct_size \
	error-rate-by-fct_size-4-241-log6b-all_fcts \
	error-rate-by-fct_size-4-241-log6b-noted_fcts \
	error-rate-by-fct_size-4-241-lin4b-all_fcts \
	error-rate-by-fct_size-4-241-lin4b-noted_fcts \
	fct_size_distrib \
	fct_size_distrib-241 \
	occ \
	faults_churn_evol \
	faults_churn \
	lifetime_across \
	cdf \
	cdf_pct \
	avg_ffi \
	reports-30
#tool_usage
DIR_JGR=$(DIR_IMG:%=%.jgr)
R_EPS=$(R_PDF:%.pdf=%.eps)

IMAGES_FIG=
IMAGES_JGR=$(wildcard *.jgr)
#size.jgr            \
#	increase-pct.jgr       \
#	$(DIR_JGR)             
#	info_result2.jgr       \
#	cmp-rate-evol-dir.jgr  \
#	faults_churn.jgr       \
#	author_graph.jgr       \
#	committer_graph.jgr    \
#	reports-2633.jgr       \
#	occ2.jgr               \
#	theta.jgr              \
#	cdf.jgr
#	$(GEN_JGR)             \
#	churn.jgr              \
#	deaths_churn.jgr       \

AVG=$(GEN_JGR:%.jgr=%.Avg.data)

all: from_db $(R_EPS)
	$(MAKE) m-all

from_db:
	$(MAKE) -C $@

include Makefile.images

distclean:: clean
	rm -f $(DIR_JGR)

clean::
	rm -f *~

rate: $(GEN_JGR)

#size.jgr: ../experiments/size/gr/code-size-stacked.jgr
#	ln -sf $^ $@

#churn.jgr: ../experiments/count_lines/churn.jgr
#	ln -sf $^ $@

#../experiments/size/gr/code-size-stacked.jgr:
#	$(MAKE) -C ../experiments/size

#../experiments/count_lines/churn.jgr:
#	$(MAKE) -C ../experiments/count_lines churn.jgr

$(DIR_JGR):
	$(MAKE) -C $(@:%.jgr=%)

avg:
	./update_avg.sh

$(R_EPS):
	pdftops -r 600 -level3 -eps $(@:%.eps=%.pdf) $@

clean-r:
	rm $(R_EPS)

#######################################################################

RPTS=new_flts new_fps inh_flts inh_fps
DATA_RPTS=$(RPTS:%=reports-2633.%.data)
$(DATA_RPTS):
	./get_reports_for_2633.sh $(@:reports-2633.%.data=%)

reports-2633.jgr: $(DATA_RPTS)

DIR=drivers staging sound arch fs net other
DATA_CMP=$(DIR:%=cmp-rate-evol-dir.%.data)
cmp-rate-evol-dir.jgr: $(DATA_CMP)
$(DATA_CMP):
	./get_rate_by_dir.sh $(@:cmp-rate-evol-dir.%.data=%) > $@

#DATA_DTH_CHURN=$(CNT:%=deaths_churn.%.data)
#DATA_FLT_RATE_CHURN=$(CNT:%=flt_rate_churn.%.data)
#deaths_churn.jgr: $(DATA_DTH_CHURN)
#flt_rate_churn.jgr: $(DATA_FLT_RATE_CHURN)
#$(DATA_DTH_CHURN):
#	./get_deaths_by_churn.sh $(@:deaths_churn.%.data=%)
#$(DATA_FLT_RATE_CHURN):
#	./get_flt_rate_by_churn.sh $(@:flt_rate_churn.%.data=%)

#cmp-rate-evol-dir.Avg.data
