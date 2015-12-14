package com.rplsd.kelompok10;


/**
 * Created by luthfi on 30/11/15.
 */

import com.dsdl.Parser;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class GeneratorController {
    @RequestMapping(value = "/generator", method = RequestMethod.POST)
    public ResponseEntity<String> generateDDL(@RequestParam(value="script") String script) {
        Parser parser = new Parser();
        //System.out.println(script);
        String ddlCode = parser.parseContent(script);
        List<String> errors = parser.getErrors();
        if (errors.size() == 0)
            return new ResponseEntity<String>(ddlCode, HttpStatus.OK);
        else{
            StringBuilder results = new StringBuilder().append("[");
            int i=1;
            for (String error : errors) {
                results.append("\"").append(error).append("\"");
                if (i < errors.size())
                    results.append(",");
                else
                    results.append("]");
                i++;
            }
            return new ResponseEntity<String>(results.toString(), HttpStatus.BAD_REQUEST);
        }
    }
}

