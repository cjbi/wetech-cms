package tech.wetech.basic.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;

import org.dbunit.DatabaseUnitException;
import org.dbunit.database.DatabaseConnection;
import org.dbunit.database.IDatabaseConnection;
import org.dbunit.database.QueryDataSet;
import org.dbunit.dataset.DataSetException;
import org.dbunit.dataset.IDataSet;
import org.dbunit.dataset.xml.FlatXmlDataSet;
import org.dbunit.dataset.xml.FlatXmlProducer;
import org.dbunit.operation.DatabaseOperation;
import org.junit.AfterClass;
import org.junit.Assert;
import org.junit.BeforeClass;
import org.xml.sax.InputSource;

public class AbstractDbUnitTestCase {
	public static IDatabaseConnection dbunitCon;
	private File tempFile;
	
	@BeforeClass
	public static void init() throws DatabaseUnitException, SQLException {
		dbunitCon = new DatabaseConnection(DbUtil.getConnection());
	}
	
	/**
	 * 根据配置文件的名称创建DateSet
	 * @param tname配置文件的名称
	 * @return
	 * @throws DataSetException
	 */
	protected IDataSet createDateSet(String tname) throws DataSetException {
		//配置文件在classes的根目录下
		InputStream is = AbstractDbUnitTestCase
					.class
					.getClassLoader().getResourceAsStream(tname+".xml");
		Assert.assertNotNull("dbunit的基本数据文件不存在",is);
		//创建DataSet
		return new FlatXmlDataSet(new FlatXmlProducer(new InputSource(is)));
	}
	
	protected void backupAllTable() throws SQLException, IOException, DataSetException {
		IDataSet ds = dbunitCon.createDataSet();
		writeBackupFile(ds);
	}
	
	private void writeBackupFile(IDataSet ds) throws IOException, DataSetException {
		tempFile = File.createTempFile("back","xml");
		FlatXmlDataSet.write(ds, new FileWriter(tempFile));
	}
	
	protected void backupCustomTable(String[] tname) throws DataSetException, IOException {
		QueryDataSet ds = new QueryDataSet(dbunitCon);
		for(String str:tname) {
			ds.addTable(str);
		}
		writeBackupFile(ds);
	}
	
	protected void bakcupOneTable(String tname) throws DataSetException, IOException {
		backupCustomTable(new String[]{tname});
	}
	
	protected void resumeTable() throws FileNotFoundException, DatabaseUnitException, SQLException {
		IDataSet ds = new FlatXmlDataSet(new FlatXmlProducer(new InputSource(new FileInputStream(tempFile))));
		DatabaseOperation.CLEAN_INSERT.execute(dbunitCon, ds);
	}
	
	
	@AfterClass
	public static void destory() {
		try {
			if(dbunitCon!=null) dbunitCon.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
