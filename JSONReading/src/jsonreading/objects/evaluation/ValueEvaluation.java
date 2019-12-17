package jsonreading.objects.evaluation;

import jsonreading.objects.Value;

/**
 *
 * @author Gabriel
 */
public class ValueEvaluation extends Value {
    
    private String rateEvent;
    private String rateConfe;
    private String rateNetwo;
    private String rateOrgan;
    private String option;
    private String comment;

    public String getRateEvent() {
        return rateEvent;
    }

    public void setRateEvent(String rateEvent) {
        this.rateEvent = rateEvent;
    }

    public String getRateConfe() {
        return rateConfe;
    }

    public void setRateConfe(String rateConfe) {
        this.rateConfe = rateConfe;
    }

    public String getRateNetwo() {
        return rateNetwo;
    }

    public void setRateNetwo(String rateNetwo) {
        this.rateNetwo = rateNetwo;
    }

    public String getRateOrgan() {
        return rateOrgan;
    }

    public void setRateOrgan(String rateOrgan) {
        this.rateOrgan = rateOrgan;
    }

    public String getOption() {
        return option;
    }

    public void setOption(String option) {
        this.option = option;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
    
    @Override
    public Object[] getObject(int index) {
        return new Object[] {index, rateEvent, rateConfe, rateNetwo, rateOrgan, option, comment, type, date, uid};
    }

    @Override
    public String toString() {
        return "Evaluation{" + "_id=" + _id + ", _rev=" + _rev + ", rateEvent=" + rateEvent + ", rateConfe=" + rateConfe + ", rateNetwo=" + rateNetwo + ", rateOrgan=" + rateOrgan + ", option=" + option + ", comment=" + comment + ", type=" + type + ", date=" + date + ", uid=" + uid + '}';
    }
    
}
