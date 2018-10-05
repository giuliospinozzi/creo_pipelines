library(shiny)
library(shinyjs)
library(drc)
library(ggplot2)
library(grid)
library(gridExtra)
library(rlist)
library(reshape2)
library(plyr)
library(tidyr)
library(gplots)

mod <- function(df) {
  fit <- drm(df$viability ~ df$dose, data=df, fct = LL.4(names=c("slope","low","high","IC50")), 
             type = "continuous")
  pred.df <- expand.grid(dose=exp(seq(log(max(df$dose)),log(min(df$dose)),length=100))) 
  pred <- predict(fit,newdata=pred.df,interval="confidence") 
  pred.df$viability <- pmax(pred[,1],0)
  pred.df$viability <- pmin(pred.df$viability,100)
  pred.df$viability.low <- pmax(pred[,2],0)
  pred.df$viability.low <- pmin(pred.df$viability.low,100)
  pred.df$viability.high <- pmax(pred[,3],0)
  pred.df$viability.high <- pmin(pred.df$viability.high,100)
  colnames(pred.df)=c("conc", "p", "pmin", "pmax")
  return(list(ic50=summary(fit)$coefficient[4,1],pred.df=pred.df))
}

shinyServer(function(input, output) {
  
  output$fileUploaded <- reactive({
    return(is.null(input$file1))
  })
  outputOptions(output, 'fileUploaded',suspendWhenHidden=FALSE)
  
  output$tab <- renderUI({
    if (is.null(input$file1)) {return(NULL)}
    conc=c(rep(input$conc1,3),rep(input$conc2,3),rep(input$conc3,3),rep(input$conc4,3))
    infile <- input$file1
    df1 <-read.csv(infile$datapath,sep=input$sep1,row.names = 1,dec=".") 
    drug=rownames(df1)
    selectInput("Drug", "Choose a drug:", choices = drug)
  })
  
  output$table <- renderTable({
    conc=c(rep(input$conc1,3),rep(input$conc2,3),rep(input$conc3,3),rep(input$conc4,3))
    if (is.null(input$file1)) {return(NULL)}
    infile <- input$file1
    df1 <-read.csv(infile$datapath,sep=input$sep1,row.names = 1,dec=".") 
    colnames(df1)=conc
    drug=rownames(df1)
    if (input$cell_num>=2) {
      if (is.null(input$file2)) {return(NULL)}
      infile <- input$file2
      df2 <-read.csv(infile$datapath,sep=input$sep2,row.names = 1,dec=".") 
      colnames(df2)=conc
    }
    if (input$cell_num>=3) {
      if (is.null(input$file3)) {return(NULL)}
      infile <- input$file3
      df3 <-read.csv(infile$datapath,sep=input$sep3,row.names = 1,dec=".") 
      colnames(df3)=conc
    }
    if (input$cell_num==4) {
      if (is.null(input$file4)) {return(NULL)}
      infile <- input$file4
      df4 <-read.csv(infile$datapath,sep=input$sep4,row.names = 1,dec=".") 
      colnames(df4)=conc
    }
    if (input$cell_num==1) {
      for (i in 1:length(drug)) {
        if (input$Drug==drug[i]) {
          a=df1[i,,drop=F]
          rownames(a)=paste(input$name1,drug[i])
          return(a)
        }
      }
    }
    if (input$cell_num==2) {
      for (i in 1:length(drug)) {
        if (input$Drug==drug[i]) {
          a=rbind(df1[i,],df2[i,])
          rownames(a)=c(paste(input$name1,drug[i]),paste(input$name2,drug[i]))
          return(a)
        }
      }
    }
    if (input$cell_num==3) {
      for (i in 1:length(drug)) {
        if (input$Drug==drug[i]) {
          a=rbind(df1[i,],df2[i,])
          a=rbind(a,df3[i,])
          rownames(a)=c(paste(input$name1,drug[i]),paste(input$name2,drug[i]),
                        paste(input$name3,drug[i]))
          return(a)
        }
      }
    }
    if (input$cell_num==4) {
      for (i in 1:length(drug)) {
        if (input$Drug==drug[i]) {
          a=rbind(df1[i,],df2[i,])
          a=rbind(a,df3[i,])
          a=rbind(a,df4[i,])
          rownames(a)=c(paste(input$name1,drug[i]),paste(input$name2,drug[i]),
                        paste(input$name3,drug[i]),paste(input$name4,drug[i]))
          return(a)
        }
      }
    }
    
  },rownames = T)
  
  output$plot <- renderPlot({
    if (is.null(input$file1)) {return(NULL)}
    infile <- input$file1
    df1 <-read.csv(infile$datapath,sep=input$sep1,row.names = 1,dec=".") 
    conc=c(rep(input$conc1,3),rep(input$conc2,3),rep(input$conc3,3),rep(input$conc4,3))
    colnames(df1)=conc
    drug=rownames(df1)
    table1=t(df1)
    pl=list()
    
    withProgress(message = 'Generating plot', detail = "part 0", value = 0, {
      for (i in 1:(ncol(table1))) {
        df=data.frame(viability=table1[,i],dose=conc)
        out_mod=mod(df)
        pred.df=out_mod[[2]]
        ic50=out_mod[[1]]
        
        p <- ggplot(df,aes(x=dose,y=viability)) +
          geom_point(aes(colour=input$name1),size=2.5) +
          labs(y="viability") +
          coord_trans(x="log")+theme_bw() +
          scale_x_continuous(name=paste0("dose (",input$unit,")"),breaks=sort(unique(df$dose))) +
          ggtitle(paste0("Drug ",colnames(table1)[i])) + 
          theme(plot.title=element_text(hjust=0.5,face="bold",size=24),
                axis.text=element_text(size=16),
                axis.title=element_text(size=18),
                legend.text=element_text(size=14),
                legend.title=element_text(size=16)) +
          theme(axis.text.x = element_text(angle = 35, hjust = 1)) +
          geom_line(data=pred.df,aes(x=conc,y=p,colour=input$name1),size=0.8) +
          geom_vline(xintercept=ic50,c,size=0.5,linetype="dashed",color=input$col1)
        
        if (input$cell_num==1) {
          cols=c(input$col1)
          names(cols)=input$name1
          p <- p + scale_colour_manual("Cell lines", breaks = input$name1,values = cols) +
            annotate("text",x=c(signif(ic50,4)), y=c(max(df$viability)),
                     label=c(signif(ic50,4)), color=c(input$col1), size=5)
        }
        
        if (input$cell_num>1) {
          if (is.null(input$file2)) {return(NULL)}
          infile <- input$file2
          d.f2 <-read.csv(infile$datapath,sep=input$sep2,row.names = 1,dec=".") 
          colnames(d.f2)=conc
          table2=t(d.f2)
          df2=data.frame(viability=table2[,i],dose=conc)
          out_mod=mod(df2)
          pred.df2=out_mod[[2]]
          ic502=out_mod[[1]]
          
          p <- p + geom_point(data=df2,aes(x=dose,y=viability,colour=input$name2),size=2.5) + 
            geom_line(data=pred.df2,aes(x=conc,y=p,colour=input$name2),size=0.8) +
            geom_vline(xintercept=ic502,c,size=0.5,linetype="dashed", 
                       color=input$col2)
        }
        
        if (input$cell_num==2) {
          cols2=c(input$col1,input$col2)
          names(cols2)=c(input$name1,input$name2)
          p <- p + 
            scale_colour_manual("Cell lines", breaks = c(input$name1,input$name2), values = cols2) +
            annotate("text", x=c(signif(ic50,4),signif(ic502,4)), 
                     y=c(max(df$viability),max(df2$viability)),
                     label=c(signif(ic50,4),signif(ic502,4)), 
                     color=c(input$col1,input$col2),size=5)
        }
        
        if (input$cell_num>2) {
          if (is.null(input$file3)) {return(NULL)}
          infile <- input$file3
          d.f3 <-read.csv(infile$datapath,sep=input$sep3,row.names = 1,dec=".") 
          colnames(d.f3)=conc
          table3=t(d.f3)
          df3=data.frame(viability=table3[,i],dose=conc)
          out_mod=mod(df3)
          pred.df3=out_mod[[2]]
          ic503=out_mod[[1]]
          
          p <- p + geom_point(data=df3,aes(x=dose,y=viability,colour=input$name3),size=2.5) + 
            geom_line(data=pred.df3,aes(x=conc,y=p,colour=input$name3),size=0.8) +
            geom_vline(xintercept=ic503,c,size=0.5,linetype="dashed",color=input$col3)
        }
        
        if (input$cell_num==3) {
          cols3=c(input$col1,input$col2,input$col3)
          names(cols3)=c(input$name1,input$name2,input$name3)
          p <- p + 
            scale_colour_manual("Cell lines", breaks = c(input$name1,input$name2,input$name3),
                                values = cols3) +
            annotate("text", x=c(signif(ic50,4),signif(ic502,4),signif(ic503,4)), 
                     y=c(max(df$viability),max(df2$viability),max(df3$viability)),
                     label=c(signif(ic50,4),signif(ic502,4),signif(ic503,4)), 
                     color=c(input$col1,input$col2,input$col3),size=5)
        }
        
        if (input$cell_num>3) {
          if (is.null(input$file4)) {return(NULL)}
          infile <- input$file4
          d.f4 <-read.csv(infile$datapath,sep=input$sep4,row.names = 1,dec=".") 
          colnames(d.f4)=conc
          table4=t(d.f4)
          df4=data.frame(viability=table4[,i],dose=conc)
          out_mod=mod(df4)
          pred.df4=out_mod[[2]]
          ic504=out_mod[[1]]
          
          p <- p + geom_point(data=df4,aes(x=dose,y=viability,colour=input$name4),size=2.5) + 
            geom_line(data=pred.df4,aes(x=conc,y=p,colour=input$name4),size=0.8) +
            geom_vline(xintercept=ic504,c,size=0.5,linetype="dashed",color=input$col4)
        }
        
        if (input$cell_num==4) {
          cols4=c(input$col1,input$col2,input$col3,input$col4)
          names(cols4)=c(input$name1,input$name2,input$name3,input$name4)
          p <- p + 
            scale_colour_manual("Cell lines", 
                                breaks = c(input$name1,input$name2,input$name3,input$name4),
                                values = cols4) +
            annotate("text", x=c(signif(ic50,4),signif(ic502,4),signif(ic503,4),signif(ic504,4)), 
                     y=c(max(df$viability),max(df2$viability),max(df3$viability),max(df4$viability)),
                     label=c(signif(ic50,4),signif(ic502,4),signif(ic503,4),signif(ic504,4)), 
                     color=c(input$col1,input$col2,input$col3,input$col4),size=5)
        }
        pl=list.append(pl,p)
        incProgress(1/ncol(table1), detail = paste0("part ", i, "/", (ncol(table1))))
      }
    })
    for (i in 1:length(drug)) {
      if (input$Drug==drug[i]) {print(pl[[i]])}
    }
  })
  
  output$downloadData <- renderUI({
    if (input$cell_num==1) {infile <- input$file1}
    if (input$cell_num==2) {infile <- input$file2}
    if (input$cell_num==3) {infile <- input$file3}
    if (input$cell_num==4) {infile <- input$file4}
    req(infile, read.csv(infile$datapath,sep=input$sep1,row.names = 1,dec="."))
    downloadButton("download",label = "Download plot")
  })
  
  output$download <- downloadHandler(
    filename = function() {"plot.pdf"},
    content = function(file) {
      ggsave(file)
    }
  )
  
  Report <- eventReactive(input$report,{
    withProgress(message = 'Generating Report', value = 0, {  
      disable("report") 
      tempReport <- file.path(tempdir(), "report.Rmd")
      file.copy("report.Rmd", tempReport, overwrite = TRUE)
      incProgress(1/3)
      params <- list(conc1 = input$conc1, conc2 = input$conc2, conc3 = input$conc3, 
                     conc4 = input$conc4, unit = input$unit, cell_num = input$cell_num,
                     name1 = input$name1, file1 = input$file1$datapath, sep1 = input$sep1,
                     col1 = input$col1, name2 = NULL, file2 = NULL, sep2 = NULL, col2 = NULL,
                     name3 = NULL, file3 = NULL, sep3 = NULL, col3 = NULL, name4 = NULL, 
                     file4 = NULL, sep4 = NULL, col4 = NULL)
      if (input$cell_num>=2) {
        params$name2 = input$name2
        params$file2 = input$file2$datapath
        params$sep2 = input$sep2
        params$col2 = input$col2
      }
      if (input$cell_num>=3) {
        params$name3 = input$name3
        params$file3 = input$file3$datapath
        params$sep3 = input$sep3
        params$col3 = input$col3
      }
      if (input$cell_num>=4) {
        params$name4 = input$name4
        params$file4 = input$file4$datapath
        params$sep4 = input$sep4
        params$col4 = input$col4
      }
      incProgress(1/3)
      rmarkdown::render(tempReport, 
                        output_file = paste0("/storage/d2/results/DrugPlates/",input$out_dir,"/report.pdf"),
                        params = params,
                        envir = new.env(parent = globalenv())
      )
      incProgress(1/3)
      enable("report")
    })
  })
  
  observe({
    if (input$report > 0) {
      dir.create(paste0("/storage/d2/results/DrugPlates/",input$out_dir))
      Report()
    }
  })
  
  output$text <- renderUI({
    if (input$report > 0) {
      url=a("Report", href=paste0("http://141.250.134.204/results/DrugPlates/",input$out_dir))
      tagList("Report is available here:", url)
    }
  })
  
  ############ synergy ################
  
  output$fileUploaded1 <- reactive({
    return(is.null(input$file1.1))
  })
  outputOptions(output, 'fileUploaded1',suspendWhenHidden=FALSE)
  
  filedata1.1 <- reactive({
    infile <- input$file0
    if (is.null(infile)) {return(NULL)}
    read.csv(infile$datapath,sep=";",row.names = 1) 
  })
  
  filedata1.2 <- reactive({
    infile <- input$file1.1
    if (is.null(infile)) {return(NULL)}
    read.csv(infile$datapath,sep=";",row.names = 1,header = F) 
  })
  
  output$syn1 <- renderTable({
    if (is.null(input$file0)) {return(NULL)}
    data=filedata1.1()
    conc.data=c(input$conc1.1,input$conc2.1,input$conc3.1,input$conc4.1,input$conc5.1,input$conc6.1,
                input$conc7.1,input$conc8.1)
    colnames(data)=rep(conc.data,3)
    rownames(data)=rev(conc.data)
    new.data=data[,1:8]
    for (j in 1:8) {
      for (i in 1:8) {
        new.data[j,i]=mean(c(data[j,i],data[j,(i+8)],data[j,(i+16)]))
      }
    }
    return(new.data)
  },rownames = T)
  
  output$syn2 <- renderTable({
    if (is.null(input$file1.1)) {return(NULL)}
    drug=filedata1.2()
    conc.drug=c(input$conc1.2,input$conc2.2,input$conc3.2,input$conc4.2,input$conc5.2,input$conc6.2,
                input$conc7.2,input$conc8.2)
    colnames(drug)=conc.drug
    rownames(drug)=c(input$name1.1,input$name2.1)
    new.drug=drug[,1:8]
    for (j in 1:2) {
      for (i in 1:8) {
        new.drug[j,i]=mean(c(drug[j,((i*3)-2)],drug[j,((i*3)-1)],drug[j,(i*3)]))
      }
    }
    return(new.drug)
  },rownames = T)
  
  dff.cre <- reactive({
    if (is.null(input$file0)) {return(NULL)}
    if (is.null(input$file1.1)) {return(NULL)}
    data=filedata1.1()
    drug=filedata1.2()
    conc.data=c(input$conc1.1,input$conc2.1,input$conc3.1,input$conc4.1,input$conc5.1,input$conc6.1,
                input$conc7.1,input$conc8.1)
    conc.drug=c(input$conc1.2,input$conc2.2,input$conc3.2,input$conc4.2,input$conc5.2,input$conc6.2,
                input$conc7.2,input$conc8.2)
    drug1=input$name1.1
    drug2=input$name2.1
    project=input$name_project
    unit=input$unit_conc
    
    # create input table
    input=data.frame(row.names = 1:240)
    drugA_syn=rep(conc.data,24)
    drugA_syn=sort(drugA_syn,decreasing = T)
    drugA_only1=rep(conc.drug,3)
    drugA_only1=sort(drugA_only1,decreasing = T)
    drugA_only0=rep(0,24)
    drugA_only=c(drugA_only1,drugA_only0)
    input$drugA=c(drugA_syn,drugA_only)
    drugB_syn=sort(conc.data)
    drugB_syn=rep(drugB_syn,3)
    drugB_syn=rep(drugB_syn,8)
    drugB_only=c(drugA_only0,drugA_only1)
    input$drugB=c(drugB_syn,drugB_only)
    value=as.vector(t(data))
    value1=as.vector(t(drug))
    input$value=c(value,value1)
    colnames(input)[1:2]=rownames(drug)
    mydata=input
    # colnames(mydata)[1]=c(input$name1.1)
    # colnames(mydata)[2]=c(input$name2.1)
    colnames(mydata)[3]=c("Signal")
    mydata[,1]=as.numeric(as.character(mydata[,1]))
    mydata[,2]=as.numeric(as.character(mydata[,2]))
    mydata[,3]=as.numeric(as.character(mydata[,3]))
    mydata2=ddply(mydata,c(colnames(mydata)[1],colnames(mydata)[2]),summarise,Fraction=mean(Signal))
    maxSignal=max(mydata2$Fraction)
    mydata2$Fraction=mydata2$Fraction/maxSignal
    mydata2=mydata2[with(mydata2,order(mydata2[,1],mydata2[,2])),]
    mydata2[1,3]=1
    
    ## remove outliners
    tmp=mydata2[,3]==1
    tmp[1]=FALSE
    mydata2=mydata2[!tmp,]
    
    # isobologram
    drug1Base=1
    drug2Base=1
    
    dose1 = mydata2[,1]/drug1Base
    dose2 = mydata2[,2]/drug2Base
    fa = 1-mydata2[,3]   ## fration of total cells or viability
    ##    Estimate the parameters in the median effect equation for single drug and their mixture at
    ##    the fixed ratio dose2/dose1=d2.d1
    fa1 = fa
    fu = 1-fa    ## death cell fraction
    resp = rep(NA, length(fa))
    resp[!(fa==0 | fa==1)] = log(fa[!(fa==0 | fa==1)]/fu[!(fa==0 | fa==1)])  ## resp=log(fa/fu)
    totdose = dose1 + dose2
    logd = log(totdose)
    
    ind1 = dose2==0 & dose1!=0
    ind2 = dose1==0 & dose2!=0
    ind3 = dose1!=0 & dose2!=0
    
    ##     Estimate the parameters using median-effect plot for two single drugs and
    ##     their combination at the fixed ratio (dose of drug 2)/(dose of drug 1)=d2.d1.
    lm1 = lm(resp[ind1]~logd[ind1])
    dm1 = exp(-summary(lm1)$coef[1,1]/summary(lm1)$coef[2,1])
    lm2 = lm(resp[ind2]~logd[ind2])
    dm2 = exp(-summary(lm2)$coef[1,1]/summary(lm2)$coef[2,1])
    lmcomb = lm(resp[ind3]~logd[ind3])
    dmcomb = exp(-summary(lmcomb)$coef[1,1]/summary(lmcomb)$coef[2,1])
    
    fa12 = fa1[ind3]
    d1 = dose1[ind3]
    d2 = dose2[ind3]
    Dx1o = dm1*(fa12/(1-fa12))^(1/summary(lm1)$coef[2,1])
    Dx2o = dm2*(fa12/(1-fa12))^(1/summary(lm2)$coef[2,1])
    
    temp = (Dx1o-d1)*Dx2o/(Dx1o*d2)
    dff = data.frame(d1=d1,d2=d2,temp=temp)
    
    dff$syn = rep(NA,length(dff$temp))
    dff$syn = ifelse(dff$temp>1,"Antagonism","Synergy")
    dff$syn[dff$temp==1] = "Additivity"
    
    dff$syn = factor(dff$syn)
    levels(dff$syn) = c("Synergy","Antagonism","Additivity")
    
    dff
  })
  
  output$isob <- renderPlot({
    
    if (is.null(input$file0)) {return(NULL)}
    if (is.null(input$file1.1)) {return(NULL)}
    
    drug1=input$name1.1
    drug2=input$name2.1
    project=input$name_project
    unit=input$unit_conc
    
    dff=dff.cre()
    
    plot(ggplot(dff,aes(x=factor(signif(d1,2)), y=factor(signif(d2,2)),
                        col=factor(syn,levels=c("Synergy","Antagonism","Additivity"))))+
           geom_point(aes(size=log(abs(temp))),shape=19)+ guides(size = FALSE)+
           scale_color_manual("Drug-Drug interaction", breaks=c("Synergy","Antagonism","Additivity"),
                              values=c("dodgerblue","firebrick1","black"))+
           scale_size_continuous("Interaction Strength", range=c(1,10))+
           xlab(paste0("\n",drug1," concentration (",unit,")"))+
           ylab(paste0(drug2," concentration (",unit,")\n"))+
           ggtitle("Isobologram",subtitle = paste0(project,"\n"))+
           theme(
             panel.background = element_blank(),
             legend.text = element_text(size = 10),
             plot.title = element_text(face="bold",colour="black",hjust = 0.5),
             plot.subtitle = element_text(face="bold",colour="black",hjust = 0.5),
             legend.position = "bottom",
             panel.grid.major = element_line(linetype = "dotted", colour = "grey"),
             panel.grid.minor = element_line(linetype = "dotted", colour = "grey50")
           ))
  })
  
  
  output$heat <- renderPlot({
    
    if (is.null(input$file0)) {return(NULL)}
    if (is.null(input$file1.1)) {return(NULL)}
    
    project=input$name_project
    unit=input$unit_conc
    drug1=input$name1.1
    drug2=input$name2.1
    
    # heatmap
    
    m=dff.cre()
    
    m$temp=log(abs(m$temp))
    m$temp=m$temp+abs(extendrange(range(c(min(m$temp),max(m$temp))))[1])
    for (i in 1:nrow(m)) {if (m$syn[i]=="Antagonism") {m$temp[i]=m$temp[i]*(-1)}}
    
    p=spread(m[,1:3], d1, temp, fill=0)
    rownames(p)=p$d2
    p=p[,2:ncol(p)]
    
    p=p[order(as.numeric(rownames(p)),decreasing = T),]
    p=p[order(as.numeric(colnames(p))),]
    
    p=as.matrix(p)
    colnames(p)=signif(as.numeric(colnames(p)),2)
    rownames(p)=signif(as.numeric(rownames(p)),2)
    
    my_palette <- colorRampPalette(c("firebrick1", "white","dodgerblue"))(n = 101)
    par(cex.main=1)
    heatmap.2(p, dendrogram = "none", scale="none", Rowv = F, Colv = F, cellnote = round(p,2),
              trace="none", density.info = "none",col = my_palette,notecol ="black",
              main=paste0("Isobologram matrix\n\n ",project), symbreaks = T,
              symkey = T, cexCol = 1, cexRow = 1,
              xlab = paste0("\n",drug1," concentration (",unit,")"),
              ylab = paste0(drug2," concentration (",unit,")\n"),
              margins=c(5,6.5))
    
  })
  
  output$report1 <- downloadHandler(
    filename = "report_synergy.pdf",
    content = function(file) {
      
      tempReport <- file.path(tempdir(), "report_synergy.Rmd")
      file.copy("report_synergy.Rmd", tempReport, overwrite = TRUE)
      
      params1 <- list(conc.data = c(input$conc1.1,input$conc2.1,input$conc3.1,input$conc4.1,
                                    input$conc5.1,input$conc6.1,input$conc7.1,input$conc8.1),
                      conc.drug=c(input$conc1.2,input$conc2.2,input$conc3.2,input$conc4.2,
                                  input$conc5.2,input$conc6.2,input$conc7.2,input$conc8.2),
                      file2 = input$file1.1$datapath, file1 = input$file0$datapath,
                      drug1 = input$name1.1, drug2 = input$name2.1, project = input$name_project,
                      unit = input$unit_conc, dff = dff.cre())
      rmarkdown::render(tempReport, output_file = file, params = params1, 
                        envir = new.env(parent = globalenv())
      )
    })
  
})
