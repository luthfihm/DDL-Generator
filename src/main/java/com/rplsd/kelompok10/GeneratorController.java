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
        else
            return new ResponseEntity<String>(errors.size()+" error(s) was found", HttpStatus.BAD_REQUEST);
    }
}
